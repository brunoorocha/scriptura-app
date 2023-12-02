//
//  APIBookRepository.swift
//  Scriptura
//
//  Created by Bruno Rocha on 29/11/23.
//

import Foundation

final class APIBookRepository: BookRepository {
    private let service: APIService
    
    init(service: APIService = APIService()) {
        self.service = service
    }
    
    func allBooks() async throws -> [Book] {
        return try await service.apiRequest(.books)
    }
}
