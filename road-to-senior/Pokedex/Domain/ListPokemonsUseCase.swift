protocol ListPokemonsUseCaseProtocol {
    func execute(_ completion: @escaping (Result<Pokedex, Error>) -> Void)
}

// command design pattern
final class ListPokemonsUseCase: ListPokemonsUseCaseProtocol {
    private let fetchPokemonListService: FetchPokemonListServiceProtocol
    
    init(fetchPokemonListService: FetchPokemonListServiceProtocol = FetchPokemonListService()) {
        self.fetchPokemonListService = fetchPokemonListService
    }
    
    func execute(_ completion: @escaping (Result<Pokedex, Error>) -> Void) {
        fetchPokemonListService.pokemons { result in
            completion(result.map {
                    Pokedex(pokemons: $0.map { .init(name: $0.name) })
            }.mapError { $0 })
        }
    }
}
