//
//  File.swift
//  
//
//  Created by Andrius Shiaulis on 27.03.2021.
//

import Foundation

extension Bundle {
    static func testForecast() -> Data! {
        Bundle
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
