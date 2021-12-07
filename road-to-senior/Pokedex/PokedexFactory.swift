import UIKit
enum PokedexFactory {
    static func make() -> UIViewController {
        let useCase = ListPokemonsUseCase()
        let adapter = PokemonListAdapter()
        let viewModel = PokemonListViewModel(
            listPokemonsUseCase: useCase,
            pokemonListManager: adapter)
        let controller = PokemonListViewController(
            pokemonAdapter: adapter,
            viewModel: viewModel)
        return controller
    }
}
