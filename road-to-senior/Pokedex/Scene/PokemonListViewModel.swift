protocol PokemonListViewModelProtocol {
    var delegate: PokemonListViewModelDelegate? { get set }
    func fetchPokemons()
}

protocol PokemonListViewModelDelegate: AnyObject {
    func pokemonsDidChange()
    func handleError()
}

final class PokemonListViewModel: PokemonListViewModelProtocol {
    // MARK: - Dependencies
    
    private let listPokemonsUseCase: ListPokemonsUseCaseProtocol
    private let pokemonListManager: PokemonListManaging
    weak var delegate: PokemonListViewModelDelegate?
    
    // MARK: Initialization
    
    init(listPokemonsUseCase: ListPokemonsUseCaseProtocol,
         pokemonListManager: PokemonListManaging) {
        self.listPokemonsUseCase = listPokemonsUseCase
        self.pokemonListManager = pokemonListManager
    }
    
    // MARK: - View modeling
    
    func fetchPokemons() {
        listPokemonsUseCase.execute { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case let .success(pokedex):
                self.pokemonListManager.configure(using: pokedex.pokemons)
                self.delegate?.pokemonsDidChange()
            case .failure(_):
                self.delegate?.handleError()
            }
        }
    }
}
