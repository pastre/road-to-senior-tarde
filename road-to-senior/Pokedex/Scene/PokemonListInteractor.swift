protocol PokemonListBusinessLogic {
    func fetchPokemons(_ request: PokemonListSceneModel.FetchPokemons.Request)
}

final class PokemonListInteractor: PokemonListBusinessLogic {
    
    private let presenter: PokemonListPresentationLogic
    
    private let useCases: UseCases
    
    struct UseCases {
        let listPokemons: ListPokemonsUseCaseProtocol
    }
    
    init(
        presenter: PokemonListPresentationLogic,
        useCases: UseCases) {
        self.presenter = presenter
            self.useCases = useCases
    }
    
    func fetchPokemons(_ request: PokemonListSceneModel.FetchPokemons.Request) {
        useCases.listPokemons.execute {
            switch $0 {
            case let .success(pokedex):
                self.presenter.presentPokemons(.init(
                    pokemons: pokedex.pokemons.reversed()
                ))
            case .failure: break
            }
        }
    }
}
