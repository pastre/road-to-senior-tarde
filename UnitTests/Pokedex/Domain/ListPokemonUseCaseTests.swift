import XCTest

@testable import road_to_senior

final class ListPokemonUseCaseTests: XCTestCase {
    // MARK: - Properties
    
    private let serviceStub = FetchPokemonListServiceStub()
    private lazy var sut = ListPokemonsUseCase(fetchPokemonListService: serviceStub)
    
    // MARK: - Unit tests
    
    func test_execute_whenApiReturns_itShouldCallCompltionMappingToPokedex() {
        // Given
        let expecetedName = UUID().uuidString
        serviceStub.pokemonsResponseToUse = .success([
            .init(name: expecetedName)
        ])
        
        // When
        
        sut.execute { result in
            // Then
            guard case let .success(actualPokemons) = result
            else { return XCTFail("Expected sut to succeed, but it failed") }
            XCTAssertEqual(expecetedName, actualPokemons.pokemons.first?.name)
        }
    }
    
    func test_execute_whenApiReturnsError_itShouldMapError() {
        // Given
        
        let expectedError = ServiceError.invalidStatusCode
        serviceStub.pokemonsResponseToUse = .failure(expectedError)
        
        // When
        
        sut.execute { result in
            // Then
            
            guard case let .failure(actualError) = result else {
                return XCTFail("Expected sut to fail, but it succeeded")
            }
            
            XCTAssertEqual(expectedError.localizedDescription,
                           actualError.localizedDescription)
        }
    }
    
}

final class FetchPokemonListServiceStub: FetchPokemonListServiceProtocol {
    var pokemonsResponseToUse: Result<[PokemonDTO], ServiceError> = .failure(.noData)
    func pokemons(_ completion: @escaping (Result<[PokemonDTO], ServiceError>) -> Void) {
        completion(pokemonsResponseToUse)
    }
}

// Testing Double
// Dummy
// Spy
// Stub -> canned answers
// Fake
// Mock
