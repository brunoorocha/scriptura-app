//
//  Chapter+Decodable.swift
//  Scriptura
//
//  Created by Bruno Rocha on 29/11/23.
//

import Foundation

extension Chapter: Decodable {
    enum CodingKeys: String, CodingKey {
        case book
        case chapter
        case verses
    
        enum BookCodingKeys: String, CodingKey {
            case name
            case version
        }
        
        enum ChapterCodingKeys: String, CodingKey {
            case number
            case verses
        }
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        let bookContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.BookCodingKeys.self, forKey: .book)
        let chapterContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.ChapterCodingKeys.self, forKey: .chapter)

        book = try bookContainer.decode(String.self, forKey: .name)
        version = try bookContainer.decode(String.self, forKey: .version)
        numberOfVerses = try chapterContainer.decode(Int.self, forKey: .verses)
        number = try chapterContainer.decode(Int.self, forKey: .number)
        verses = try rootContainer.decode([Verse].self, forKey: .verses)
    }
}

extension Verse: Decodable {
    enum CodingKeys: String, CodingKey {
        case number
        case text
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        number = try container.decode(Int.self, forKey: .number)
        text = try container.decode(String.self, forKey: .text)
    }
}
