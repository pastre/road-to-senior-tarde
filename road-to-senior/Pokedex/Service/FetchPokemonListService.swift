import Foundation

protocol FetchPokemonListServiceProtocol {
    func pokemons(_ completion: @escaping (Result<[PokemonDTO], ServiceError>) -> Void)
}

enum ServiceError: Error {
    case decodingError(Error)
    case noData
    case external(Error)
    case invalidStatusCode
}

final class FetchPokemonListService: FetchPokemonListServiceProtocol {
    func pokemons(_ completion: @escaping (Result<[PokemonDTO], ServiceError>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
            fatalError("Invalid API")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                if let error = error {
                    completion(.failure(.external(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200
                else {
                    completion(.failure(.invalidStatusCode))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(ResponseDTO.self, from: data)
                    completion(.success(response.pokemons))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }.resume()
    }
}
