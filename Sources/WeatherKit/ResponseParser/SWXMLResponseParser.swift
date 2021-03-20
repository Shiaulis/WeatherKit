//
//  File.swift
//  
//
//  Created by Andrius Shiaulis on 06.03.2021.
//

import Foundation
import Logger
import SWXMLHash

private struct SWXMLResponseParserLoggerModule: LoggerModule {}

private enum Element: String {

    // forecast
    case forecasts, forecast, night, day, phenomenon, tempmin, tempmax, text, place, name, wind, direction, speedmin, speedmax, gust, sea, peipsi

    // observations
    case observations, station, wmocode, longitude, latitude, visibility, precipitations, airpressure, relativehumidity, airtemperature
    case winddirection, windspeed, windspeedmax, waterlevel, waterlevel_eh2000, watertemperature, uvindex

    init?(_ name: String) {
        self.init(rawValue: name)
    }
}


public final class SWXMLResponseParser {

    // MARK: - Properties

    private let logger: Logger
    private let dateFormatter: DateFormatter

    // MARK: - Init

    public init() {
        self.logger = PrintLogger(loggerModule: SWXMLResponseParserLoggerModule())
        self.dateFormatter = .init()
        self.dateFormatter.locale = .init(identifier: "et-EE")
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
    }
}

extension SWXMLResponseParser: ResponseParser {

    func parse(forecastData: Data) -> Result<[ForecastDisplayItem], Swift.Error> {
        self.logger.log(information: "Parsing started")
        let xml = SWXMLHash.lazy(forecastData)
        let forecasts = parseForecasts(from: xml)
        self.logger.log(information: "Parsing finished. Parsed \(forecasts.count) forecasts")
        
        return .success(forecasts)
    }

}

// MARK: - Display items from XMLIndexer

extension SWXMLResponseParser {

    private func parseForecasts(from indexer: XMLIndexer) -> [ForecastDisplayItem] {
        indexer[.forecasts][.forecast].all.map { parseForecast(from: $0) }
    }

    private func parseForecast(from indexer: XMLIndexer) -> ForecastDisplayItem {
        ForecastDisplayItem(
            naturalDateDescription: "",
            shortDateDescription: "",
            day: dayPartForecast(from: indexer[.day], dayPartType: .day),
            night: dayPartForecast(from: indexer[.night], dayPartType: .night)
        )
    }

    private func dayPartForecast(from indexer: XMLIndexer, dayPartType: DayPartForecastDisplayItem.DayPartType) -> DayPartForecastDisplayItem {
        .init(
            type: dayPartType,
            weatherIconName: weatherIconName(from: indexer),
            weatherDescription: indexer[.phenomenon].element?.text,
            temperatureRange: temperatureRangeSting(from: indexer),
            description: indexer[.text].element?.text,
            places: []
        )
    }

    private func place(from indexer: XMLIndexer) -> PlaceDisplayItem {
        .init(name: indexer[.name].element?.text,
              weatherIconName: weatherIconName(from: indexer),
              temperature: indexer[.tempmin].element?.text
        )
    }

    // MARK: - Helpers

    private func dateAttribute(from indexer: XMLIndexer) throws -> Date {
        guard let dateString = indexer.element?.attribute(by: "date")?.text else {
            throw Error.forecastDateNotFound
        }

        guard let date = self.dateFormatter.date(from: dateString) else {
            throw Error.forecastDateNotFound
        }

        return date
    }

    private func weatherIconName(from indexer: XMLIndexer) -> String? {
        let phenomenon = indexer[.phenomenon].element?.text
        let weatherType = WeatherType(phenomenonName: phenomenon)
        return weatherType?.imageName
    }

    private func temperatureRangeSting(from indexer: XMLIndexer) -> String? {
        let minimumTemperatureValue = integerValue(from: indexer[.tempmin].element?.text)
        let maximumTemperatureValue = integerValue(from: indexer[.tempmax].element?.text)

        return temperatureRangeSting(min: minimumTemperatureValue, max: maximumTemperatureValue)
    }

    private func integerValue(from stringValue: String?) -> Int? {
        guard let stringValue = stringValue else { return nil }
        guard let integerValue = Int(stringValue) else { return nil }
        return integerValue
    }

    private func temperatureRangeSting(min: Int?, max: Int?) -> String? {
        let string: String
        switch (min, max) {
        case (.none, .some(let max)): string = temperatureString(for: max)
        case (.some(let min), .none): string = temperatureString(for: min)
        case (.none, .none): return nil
        case (.some(let min), .some(let max)): string = "\(temperatureString(for: min)) | \(temperatureString(for: max))"
        }

        return string
    }

    private func temperatureString(for value: Int) -> String {
        switch value {
        case 1...: return "\(String(describing: value))°"
        case 0: return "0°"
        case (Int.min..<0): return "-\(String(describing: abs(Int32(value))))°"
        default:
            assertionFailure("Should be unreachable")
            return ""
        }
    }

}

// MARK: - Error type

extension SWXMLResponseParser {

    enum Error: Swift.Error {
        case elementNotFound(identifier: String)
        case forecastDateNotFound
    }

}

private extension XMLIndexer {

    subscript(element: Element) -> XMLIndexer {
        do {
            return try self.byKey(element.rawValue)
        }
        catch let error as IndexingError {
            return .xmlError(error)
        }
        catch {
            return .xmlError(IndexingError.key(key: element.rawValue))
        }
    }
}
