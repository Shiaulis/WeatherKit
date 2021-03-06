//
//  File.swift
//  
//
//  Created by Andrius Shiaulis on 06.03.2021.
//

import Foundation

public final class NetwokWeatherModel: WeatherModel {

    // MARK: - Properties

    let currentForecasts: [ForecastDisplayItem] = []
    private let weatherLocale: WeatherLocale

    // MARK: - Init

    public init(weatherLocale: WeatherLocale) {
        self.weatherLocale = weatherLocale
    }

    func provideForecasts(result: @escaping (Result<[ForecastDisplayItem], Error>) -> Void) {

    }

}
