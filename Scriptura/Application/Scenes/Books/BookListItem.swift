//
//  BookListItem.swift
//  Scriptura
//
//  Created by Bruno Rocha on 28/11/23.
//

import Foundation

struct BookListItem: Hashable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let numberOfChapters: Int
    let selectedChapter: Int?
    
    init(id: UUID = UUID(), name: String, numberOfChapters: Int, selectedChapter: Int? = nil) {
        self.id = id
        self.name = name
        self.numberOfChapters = numberOfChapters
        self.selectedChapter = selectedChapter
    }
}

extension BookListItem {
    static func fromDomainBook(_ book: Book) -> BookListItem {
        return .init(name: book.name, numberOfChapters: book.numberOfChapters)
    }
}
