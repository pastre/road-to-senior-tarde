import UIKit

final class PokemonListViewController: UIViewController {
    
    private var pokemonListView: PokemonListViewProtocol? { view as? PokemonListViewProtocol }
    private let pokemonAdapter: PokemonListAdapting
    
    init(pokemonAdapter: PokemonListAdapting = PokemonListAdapter()) {
        self.pokemonAdapter = pokemonAdapter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PokemonListView(
            dataSource: pokemonAdapter,
            delegate: pokemonAdapter)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pokemonAdapter.configure(using: [
            .init(name: UUID().uuidString),
            .init(name: UUID().uuidString),
            .init(name: UUID().uuidString),
            .init(name: UUID().uuidString),
            .init(name: UUID().uuidString),
            .init(name: UUID().uuidString),
        ])
        
        pokemonListView?.reloadData()
    }
}
