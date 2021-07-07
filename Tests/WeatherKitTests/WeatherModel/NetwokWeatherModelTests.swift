import XCTest
import Combine
@testable import WeatherKit

final class NetwokWeatherModelTests: XCTestCase {

    // MARK: - Properties

    static var allTests = [
        ("testModel", testModel),
    ]

    private var sut: NetwokWeatherModel!
    private var responseParser: ResponseParser!
    private var networkClient: MockNetworkClient!

    // MARK: - Setup and teardown

    override func setUp() {
        let locale: WeatherLocale = .estonian
        self.responseParser = MockResponseParser()
        self.networkClient = MockNetworkClient()
        self.sut = NetwokWeatherModel(weatherLocale: locale, responseParser: self.responseParser, networkClient: self.networkClient)
    }

    override func tearDown() {
        self.sut = nil
    }

    // MARK: - Tests

    func testModel() {
        // TODO: New async/await aproach should be covered here
    }

    // MARK: Helpers

    private func givenCorrectData() {
        self.networkClient.outputData = Bundle.testForecast()
    }
}

private class MockResponseParser: ResponseParser {

    func parse(forecastData: Data) -> Result<[ForecastDisplayItem], Error> {
        .success([.init(naturalDateDescription: "", shortDateDescription: "", day: nil, night: nil)])
    }

}

private class MockNetworkClient: NetworkClient {

    func data(from endpoint: Endpoint) async throws -> (Data, URLResponse) {
        let response = HTTPURLResponse(url: try! endpoint.generateURL(), statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!

        return (self.outputData, response)
    }


    var outputData: Data!

    func requestPublisher(for endpoint: Endpoint) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        let response = HTTPURLResponse(url: try! endpoint.generateURL(), statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        return Just((data: self.outputData, response: response))
            .setFailureType(to: Swift.Error.self)
            .eraseToAnyPublisher()
    }
}
