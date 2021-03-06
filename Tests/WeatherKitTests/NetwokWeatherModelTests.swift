import XCTest
@testable import WeatherKit

final class NetwokWeatherModelTests: XCTestCase {

    // MARK: - Properties

    static var allTests = [
        ("testExample", testExample),
    ]

    private var sut: NetwokWeatherModel!

    // MARK: - Setup and teardown

    override func setUp() {
        let locale: WeatherLocale = Locale(identifier: "en")
        self.sut = NetwokWeatherModel(weatherLocale: locale)
    }

    override func tearDown() {
        self.sut = nil
    }

    // MARK: - Tests

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertNotNil(self.sut)
    }
}
