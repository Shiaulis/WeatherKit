//
//  ForecastDateFormatterTests.swift
//  
//
//  Created by Andrius Siaulis on 14.11.2021.
//

import Foundation
import XCTest
@testable import WeatherKit

final class ForecastDateFormatterTests: XCTestCase {
    
    private var sut: ForecastDateFormatter!
    
    override func setUp() {
        self.sut = .init()
    }
    
    override func tearDown() {
        self.sut = nil
    }
    
    func test_validStringDate_producesCorrectDate() throws {
        let validDateString = "2020-01-13"
        let date = try self.sut.date(from: validDateString)
        XCTAssertEqual(try validDateString.dateWithDefaultStrategy(), date)
    }
    
    func test_validDate_onRussianLocale_hasHumanReadableDescription() throws {
        let validDateString = "2021-11-14"
        let date = try validDateString.dateWithDefaultStrategy()
        self.sut.locale = .init(identifier: "ru")
        XCTAssertEqual("14 ноября", self.sut.humanReadableDescription(for: date))
    }
    
    func test_validDate_onEnglishLocale_hasHumanReadableDescription() throws {
        let validDateString = "2021-11-14"
        let date = try validDateString.dateWithDefaultStrategy()
        self.sut.locale = .init(identifier: "en")
        XCTAssertEqual("November 14", self.sut.humanReadableDescription(for: date))
    }
    
    func test_validDate_onEstonianLocale_hasHumanReadableDescription() throws {
        let validDateString = "2021-11-14"
        let date = try validDateString.dateWithDefaultStrategy()
        self.sut.locale = .init(identifier: "et")
        XCTAssertEqual("14. november", self.sut.humanReadableDescription(for: date))
    }
    
}

private extension String {
    func dateWithDefaultStrategy() throws -> Date {
        let strategy = Date.ParseStrategy(
            format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)",
            timeZone: try .timeZone(hoursFromGMT: 2)
        )
        return try Date(self, strategy: strategy)
    }
}

private extension TimeZone {
    
    enum Error: Swift.Error {
        case unableToCreateTimezone
    }
    
    static func timeZone(hoursFromGMT: Int) throws -> TimeZone {
        guard let timeZone = TimeZone(secondsFromGMT: 60 * 60 * hoursFromGMT) else {
            throw Error.unableToCreateTimezone
        }
        
        return timeZone
    }
}
