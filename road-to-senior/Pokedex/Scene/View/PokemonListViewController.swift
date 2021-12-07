import UIKit

final class PokemonListViewController: UIViewController {
    // MARK: - Dependencies
    
    private let pokemonAdapter: PokemonListAdapting
    private var viewModel: PokemonListViewModelProtocol
    
    // MARK: - Properties
    
    private var pokemonListView: PokemonListViewProtocol? {
        view as? PokemonListViewProtocol
    }
    
    // MARK: - Initialization
    
    init(pokemonAdapter: PokemonListAdapting,
         viewModel: PokemonListViewModelProtocol
    ) {
        self.pokemonAdapter = pokemonAdapter
        self.viewModel = viewModel
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
    
    override func viewDidLoad() {
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchPokemons()
    }
    
    // MARK: - Helpers
    
    private func bind() {
        viewModel.delegate = self
    }
}

extension PokemonListViewController: PokemonListViewModelDelegate {
    func pokemonsDidChange() {
        pokemonListView?.reloadData()
    }
    
    func handleError() {
        // TODO
    }
}
