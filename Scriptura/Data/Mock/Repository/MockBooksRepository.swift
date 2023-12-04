//
//  MockBooksRepository.swift
//  Scriptura
//
//  Created by Bruno Rocha on 28/11/23.
//

import Foundation

struct MockBooksRepository: BookRepository {
    func allBooks() async throws -> [Book] {
        return [
            .init(name: "Gênesis", author: "Moisés", numberOfChapters: 50, group: "Pentatêuco", testament: "VT", abbreviation: "gn"),
            .init(name: "Êxodo", author: "Moisés", numberOfChapters: 40, group: "Pentatêuco", testament: "VT", abbreviation: "ex"),
            .init(name: "Levítico", author: "Moisés", numberOfChapters: 27, group: "Pentatêuco", testament: "VT", abbreviation: "lv"),
            .init(name: "Números", author: "Moisés", numberOfChapters: 36, group: "Pentatêuco", testament: "VT", abbreviation: "nn"),
            .init(name: "Deuteronômio", author: "Moisés", numberOfChapters: 34, group: "Pentatêuco", testament: "VT", abbreviation: "dt"),
        ]
    }
}
