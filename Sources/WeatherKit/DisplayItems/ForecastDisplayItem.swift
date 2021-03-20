//
//  File.swift
//  
//
//  Created by Andrius Shiaulis on 06.03.2021.
//

import Foundation

struct ForecastDisplayItem: Identifiable {
    let id = UUID()
    let naturalDateDescription: String
    let shortDateDescription: String
    var dayParts: [DayPartForecastDisplayItem] { [self.night, self.day].compactMap { $0 } }
    let day: DayPartForecastDisplayItem?
    let night: DayPartForecastDisplayItem?
}

struct DayPartForecastDisplayItem: Identifiable {
    enum DayPartType {
        case day, night
    }

    let id = UUID()
    let type: DayPartType
    let weatherIconName: String?
    let weatherDescription: String?
    let temperatureRange: String?
    let description: String?
    let places: [PlaceDisplayItem]
}

struct PlaceDisplayItem: Identifiable {
    let id = UUID()
    let name: String?
    let weatherIconName: String?
    let temperature: String?
}

extension ForecastDisplayItem {
    static var test1: ForecastDisplayItem {
        .init(
            naturalDateDescription: "Today, 17 January",
            shortDateDescription: "Послезавтра",
            day: DayPartForecastDisplayItem.test2,
            night: DayPartForecastDisplayItem.test
        )
    }

    static var test2: ForecastDisplayItem {
        .init(
            naturalDateDescription: "19 January",
            shortDateDescription: "19.01",
            day: DayPartForecastDisplayItem.test2,
            night: DayPartForecastDisplayItem.test
        )
    }

    static var test3: ForecastDisplayItem {
        .init(
            naturalDateDescription: "19 January",
            shortDateDescription: "19.01",
            day: DayPartForecastDisplayItem.test3,
            night: DayPartForecastDisplayItem.test
        )
    }
}

extension DayPartForecastDisplayItem {

    static var test: DayPartForecastDisplayItem {
        .init(
            type: .night,
            weatherIconName: "cloud.sun.bolt.fill",
            weatherDescription: "Moderate showwwwer",
            temperatureRange: "-20 | 30",
            description:
            """
            Partly cloudy. At first locally some rain. West wind 5-11,
            on coasts in gusts 15, at first on northern coast up to 18 m/s.
            Air temperature -2..+3∞C. Slippery roads!
            """,
            places: [
                PlaceDisplayItem.test1,
                PlaceDisplayItem.test2
            ]
        )
    }

    static var test2: DayPartForecastDisplayItem {
        .init(
            type: .day,
            weatherIconName: "cloud.sun.bolt.fill",
            weatherDescription: "Rain",
            temperatureRange: "–2…+3",
            description:
            """
            Partly cloudy. At first locally some rain. West wind 5-11,
            on coasts in gusts 15, at first on northern coast up to 18 m/s.
            Air temperature -2..+3∞C. Slippery roads!
            """,
            places: [
                PlaceDisplayItem.test1,
                PlaceDisplayItem.test2
            ]
        )
    }

    static var test3: DayPartForecastDisplayItem {
        .init(
            type: .day,
            weatherIconName: "cloud.sun.bolt.fill",
            weatherDescription: "Rain",
            temperatureRange: "–20|+30",
            description:
            """
            Partly cloudy. At first locally some rain. West wind 5-11,
            on coasts in gusts 15, at first on northern coast up to 18 m/s.
            Air temperature -2..+3∞C. Slippery roads!
            """,
            places: [
                PlaceDisplayItem.test1,
                PlaceDisplayItem.test2
            ]
        )
    }

    static var test4: DayPartForecastDisplayItem {
        .init(
            type: .day,
            weatherIconName: "cloud.sun.bolt.fill",
            weatherDescription: "Rain",
            temperatureRange: "–20|+30",
            description:
            """
            Partly cloudy. At first locally some rain. West wind 5-11,
            on coasts in gusts 15, at first on northern coast up to 18 m/s.
            Air temperature -2..+3∞C. Slippery roads!
            """,
            places: [
                PlaceDisplayItem.test1,
                PlaceDisplayItem.test2
            ]
        )
    }
}

extension PlaceDisplayItem {

    static var test1: PlaceDisplayItem {
        .init(
            name: "Harku",
            weatherIconName: "cloud.sun.bolt.fill",
            temperature: "+1"
        )
    }

    static var test2: PlaceDisplayItem {
        .init(
            name: "Jõhvi",
            weatherIconName: "cloud.sun.bolt.fill",
            temperature: "+1"
        )
    }

}
