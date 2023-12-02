//
//  BookRepository.swift
//  Scriptura
//
//  Created by Bruno Rocha on 28/11/23.
//

import Foundation

protocol BookRepository {
    func allBooks() async throws -> [Book]
}
