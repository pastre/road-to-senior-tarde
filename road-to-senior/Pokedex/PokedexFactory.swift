import UIKit
enum PokedexFactory {
    static func make() -> UIViewController {
        let adapter = PokemonListAdapter()
        
        let presenter = PokemonListPresentater()
        let interactor = PokemonListInteractor(
            presenter: presenter,
            useCases: .init(
                listPokemons: ListPokemonsUseCase()
            ))
        let controller = PokemonListViewController(
            pokemonAdapter: adapter,
            interactor: interactor)
        presenter.viewController = controller
        return controller
    }
}
