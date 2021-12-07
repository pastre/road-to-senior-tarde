// DTO -> Data Transfer Object

struct PokemonDTO: Decodable {
    let name: String
}

struct ResponseDTO: Decodable {
    let pokemons: [PokemonDTO]
    enum CodingKeys: String, CodingKey {
        case pokemons = "results"
    }
}
