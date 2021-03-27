//
//  File.swift
//  
//
//  Created by Andrius Shiaulis on 06.03.2021.
//

import Foundation
import Combine

public protocol NetworkClient {
    func requestPublisher(for endpoint: Endpoint) -> AnyPublisher<(data: Data, response: URLResponse), Swift.Error>
}

final public class URLSessionNetworkClient: NSObject {

    private let urlSession = URLSession.shared

}

extension URLSessionNetworkClient: NetworkClient {

    public func requestPublisher(for endpoint: Endpoint) -> AnyPublisher<(data: Data, response: URLResponse), Swift.Error> {
        let request: URLRequest
        do {
            request = try  endpoint.generateRequest()
        }
        catch {
            return Fail<(data: Data, response: URLResponse), Swift.Error>(error: error)
                .eraseToAnyPublisher()
        }
        return self.urlSession.dataTaskPublisher(for: request)
            .mapError { Error.dataTaskError(urlError: $0) }
            .eraseToAnyPublisher()
    }

    public enum Error: Swift.Error {
        case noDataFoundInResponse
        case dataTaskError(urlError: URLError)
    }

}
