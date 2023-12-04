//
//  APIRequest.swift
//  Scriptura
//
//  Created by Bruno Rocha on 29/11/23.
//

import Foundation

protocol APIRequest {
    var baseURL: String { get }
    var endpoint: String { get }
    var urlRequest: URLRequest? { get }
}

extension APIRequest {
    var urlRequest: URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = endpoint
        guard let url = urlComponents.url else { return nil }
        return URLRequest(url: url)
    }
}

extension APIService {
    func request<T: Decodable>(_ request: APIRequest) async throws -> T {
        guard let urlRequest = request.urlRequest else {
            throw Error.invalidRequest
        }
        return try await self.request(urlRequest)
    }
}
