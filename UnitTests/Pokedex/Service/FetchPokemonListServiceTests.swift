import XCTest

@testable import road_to_senior

final class FetchPokemonListServiceTests: XCTestCase {
    // MARK: - Properties
    
    private let queueFake = DispatchQueueFake()
    private let taskSpy = URLSessionDataTaskSpy()
    private lazy var sessionStub = URLSessionStub(taskToReturn: taskSpy)
    private lazy var sut = FetchPokemonListService(
        urlSession: sessionStub,
        queue: queueFake)
    
    // MARK: - Unit tests
    
    func test_pokemons_whenThereIsNoData_itShouldCompleteWithNoData() {
        // Given / When
        sut.pokemons { result in
            // Then
            
            guard case let .failure(error) = result
            else { return XCTFail("Expected function to fail, but got \(result)") }
            XCTAssertEqual(
                error.localizedDescription,
                ServiceError.noData.localizedDescription)
        }
    }
}

// MARK: - Testing Doubles
final class DispatchQueueFake: Dispatching {
    func async(work: @escaping () -> Void) {
        work()
    }
}

final class URLSessionStub: URLSessionProtocol {
    
    var dataToUse: Data?
    var responseToUse: URLResponse?
    var errorToUse: Error?
    
    let taskToReturn: URLSessionDataTaskSpy
    
    init(taskToReturn: URLSessionDataTaskSpy) {
        self.taskToReturn = taskToReturn
    }
    
    func dataTask(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(dataToUse, responseToUse, errorToUse)
        return taskToReturn
    }
}

final class URLSessionDataTaskSpy: URLSessionDataTaskProtocol {
    
    private(set) var resumeCallCount = 0
    func resume() {
        resumeCallCount += 1
    }
}
