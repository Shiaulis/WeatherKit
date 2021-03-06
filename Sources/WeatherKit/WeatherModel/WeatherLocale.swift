//
//  File.swift
//  
//
//  Created by Andrius Shiaulis on 06.03.2021.
//

import Foundation

public protocol WeatherLocale {
    static var currentLocale: WeatherLocale { get }
}

extension Locale: WeatherLocale {
    public static var currentLocale: WeatherLocale {
        Self.current
    }

}
