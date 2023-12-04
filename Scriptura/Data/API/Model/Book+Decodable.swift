//
//  Book+Decodable.swift
//  Scriptura
//
//  Created by Bruno Rocha on 28/11/23.
//

import Foundation

extension Book: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case author
        case numberOfChapters = "chapters"
        case group
        case testament
        case abbreviation = "abbrev"
        
        enum AbbreviationCodingKeys: String, CodingKey {
            case pt
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let abbreviationContainer = try container.nestedContainer(keyedBy: CodingKeys.AbbreviationCodingKeys.self, forKey: .abbreviation)

        name = try container.decode(String.self, forKey: .name)
        author = try container.decode(String.self, forKey: .author)
        numberOfChapters = try container.decode(Int.self, forKey: .numberOfChapters)
        group = try container.decode(String.self, forKey: .group)
        testament = try container.decode(String.self, forKey: .testament)
        abbreviation = try abbreviationContainer.decode(String.self, forKey: .pt)
    }
}
