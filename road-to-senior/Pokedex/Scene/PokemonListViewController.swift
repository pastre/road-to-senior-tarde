import UIKit

protocol PokemonListDisplayLogic: AnyObject {
    func displayPokemons(_ viewModel: PokemonListSceneModel.FetchPokemons.ViewModel)
}

final class PokemonListViewController: UIViewController {
    // MARK: - Dependencies
    
    private let pokemonAdapter: PokemonListAdapting
    private let interactor: PokemonListBusinessLogic
    
    // MARK: - Properties
    
    private var pokemonListView: PokemonListViewProtocol? {
        view as? PokemonListViewProtocol
    }
    
    // MARK: - Initialization
    
    init(pokemonAdapter: PokemonListAdapting,
         interactor: PokemonListBusinessLogic
    ) {
        self.pokemonAdapter = pokemonAdapter
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller lifecycle
    
    override func loadView() {
        view = PokemonListView(
            dataSource: pokemonAdapter,
            delegate: pokemonAdapter)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.fetchPokemons(.init())
    }
}

extension PokemonListViewController: PokemonListDisplayLogic {
    func displayPokemons(_ viewModel: PokemonListSceneModel.FetchPokemons.ViewModel) {
        pokemonAdapter.configure(using: viewModel.pokemons)
        pokemonListView?.reloadData()
    }
}
