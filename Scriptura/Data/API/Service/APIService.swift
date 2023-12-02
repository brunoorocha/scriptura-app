//
//  APIService.swift
//  Scriptura
//
//  Created by Bruno Rocha on 29/11/23.
//

import Foundation

final class APIService {
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
    
    func request<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw Error.requestFailed(statusCode: httpResponse.statusCode)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension APIService {
    enum Error: Swift.Error {
        case requestFailed(statusCode: Int)
        case invalidRequest
    }
}
