//
//  ReaderVerseItem.swift
//  Scriptura
//
//  Created by Bruno Rocha on 29/11/23.
//

import Foundation

struct ReaderVerseItem: Hashable, Equatable, Identifiable {
    let id = UUID()
    let number: String
    let text: String
}

extension ReaderVerseItem {
    static func fromDomainVerse(_ verse: Verse) -> ReaderVerseItem {
        return ReaderVerseItem(number: String(verse.number), text: verse.text)
    }
}
