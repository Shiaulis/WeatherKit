//
//  File.swift
//  
//
//  Created by Andrius Shiaulis on 06.03.2021.
//

import XCTest
import Foundation
@testable import WeatherKit

final class SWXMLResponseParserTests: XCTestCase {

    // MARK: - Propeties:

    private var sut: SWXMLResponseParser!
    private var data: Data!

    // MARK: - Setup and teardown

    override func setUp() {
        self.data = nil
        self.sut = SWXMLResponseParser(logger: .init(subsystem: "", category: ""))
    }

    override func tearDown() {
        self.sut = nil
    }

    // MARK: - Tests

    func test_parseValidXML_receiveCorrectForecastNumber() {
        givenCorrectData()
        var forecasts: [ForecastDisplayItem]?
        XCTAssertNoThrow(forecasts = try self.sut.parse(forecastData: self.data).get())
        XCTAssertEqual(forecasts?.count, 4)
    }

    func test_parseInvalidXML_receiveCorrectForecastNumber() {
        givenIncorrectData()
        var forecasts: [ForecastDisplayItem]?
        XCTAssertNoThrow(forecasts = try self.sut.parse(forecastData: self.data).get())
        XCTAssertEqual(forecasts?.count, 0)
    }

    // MARK: - Private

    private func givenCorrectData() {
        self.data = Bundle.testForecast()
    }

    private func givenIncorrectData() {
        self.data = Data(count: 32).base64EncodedData()
    }
}
