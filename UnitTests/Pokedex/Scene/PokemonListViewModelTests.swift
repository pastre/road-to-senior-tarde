import XCTest

@testable import road_to_senior

final class PokemonListViewModelTests: XCTestCase {
    // MARK: - Properties
    private let delegateSpy = PokemonListViewModelDelegateSpy()
    private let pokemonListManagerSpy = PokemonListManagerSpy()
    private let useCaseStub = ListPokemonsUseCaseStub()
    private lazy var sut: PokemonListViewModel = {
        let sut = PokemonListViewModel(
            listPokemonsUseCase: useCaseStub,
            pokemonListManager: pokemonListManagerSpy)
        sut.delegate = delegateSpy
        return sut
    }()
    
    // MARK: - Unit tests
    
    func test_fetchPokemons_whenRequestSucceeds_itShouldConfigureManager_andUpdateView() {
        // Given
        useCaseStub.resultToUse = .success(.init(pokemons: []))
        
        // When
        sut.fetchPokemons()
        
        // Then
        XCTAssertEqual(1, pokemonListManagerSpy.configureCallCount)
        XCTAssertEqual(1, delegateSpy.pokemonsDidChangeCallCount)
    }
    
    func test_fetchPokemons_whenRequestFails_itShouldDelegateErrorHandling() {
        // Given
        let dummyError = NSError(domain: "", code: 0, userInfo: nil)
        useCaseStub.resultToUse = .failure(dummyError)
        
        // When
        sut.fetchPokemons()
        
        // Then
        XCTAssertEqual(1, delegateSpy.handleErrorCallCount)
    }
}

final class ListPokemonsUseCaseStub: ListPokemonsUseCaseProtocol {
    var resultToUse: Result<Pokedex, Error> = .success(.init(pokemons: []))
    func execute(_ completion: @escaping (Result<Pokedex, Error>) -> Void) {
        completion(resultToUse)
    }
}

final class PokemonListManagerSpy: PokemonListManaging {
    
    private(set) var configureCallCount = 0
    func configure(using pokemons: [Pokemon]) {
        configureCallCount += 1
    }
}

final class PokemonListViewModelDelegateSpy: PokemonListViewModelDelegate {
    private(set) var handleErrorCallCount = 0
    func handleError() {
        handleErrorCallCount += 1
    }
    
    private(set) var pokemonsDidChangeCallCount = 0
    func pokemonsDidChange() {
        pokemonsDidChangeCallCount += 1
    }
}
// Stub, Fake
