//
//  File.swift
//  
//
//  Created by Andrius Shiaulis on 06.03.2021.
//

import Foundation
import Combine

@available(iOS 15, *)
public protocol NetworkClient {

    func data(from endpoint: Endpoint) async throws -> (Data, URLResponse)

}

final public class URLSessionNetworkClient: NSObject {

    private let urlSession = URLSession.shared

}

@available(iOS 15, *)
extension URLSessionNetworkClient: NetworkClient {

    public func data(from endpoint: Endpoint) async throws -> (Data, URLResponse) {
        let request = try endpoint.generateRequest()
        return try await self.urlSession.data(for: request)
    }

    public enum Error: Swift.Error {
        case noDataFoundInResponse
        case dataTaskError(urlError: URLError)
        case notSupportedIOSVersion
    }

}
