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

protocol Dispatching {
    func async(work: @escaping () -> Void)
}

extension DispatchQueue: Dispatching {
    func async(work: @escaping () -> Void) {
        self.async(execute: work)
    }
}

protocol URLSessionProtocol {
    func dataTask(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension URLSession: URLSessionProtocol {
    func dataTask(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        self.dataTask(with: url, completionHandler: completionHandler)
    }
}

final class FetchPokemonListService: FetchPokemonListServiceProtocol {
    
    private let urlSession: URLSessionProtocol
    private let queue: Dispatching
    
    init(
        urlSession: URLSessionProtocol = URLSession.shared,
        queue: Dispatching = DispatchQueue.main
    ) {
        self.urlSession = urlSession
        self.queue = queue
    }
    
    
    func pokemons(_ completion: @escaping (Result<[PokemonDTO], ServiceError>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
            fatalError("Invalid API")
        }
        
        urlSession.dataTask(url) { [queue] data, response, error in
            queue.async {
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
