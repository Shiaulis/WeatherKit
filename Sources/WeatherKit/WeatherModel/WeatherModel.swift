//
//  File.swift
//  
//
//  Created by Andrius Shiaulis on 06.03.2021.
//

import Foundation

public protocol WeatherModel {
    var currentForecasts: [ForecastDisplayItem] { get }

    func provideForecasts(result: @escaping (Result<[ForecastDisplayItem], Error>) -> Void)

    func forecasts() async throws -> [ForecastDisplayItem]
}
