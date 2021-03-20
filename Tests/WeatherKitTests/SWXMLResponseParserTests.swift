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
        self.sut = SWXMLResponseParser()
    }

    override func tearDown() {
        self.sut = nil
    }

    // MARK: - Tests

    func testExample() {
        givenCorrectData()
        let forecasts = self.sut.parse(forecastData: self.data)
        XCTAssertNotNil(self.sut)
    }

    // MARK: - Private

    private func givenCorrectData() {
        self.data = Bundle
            .module
            .url(forResource: "TestForecast", withExtension: "xml")?
            .dataContent()
    }
}

private extension URL {
    func dataContent() -> Data! {
        try! Data(contentsOf: self)
    }
}
