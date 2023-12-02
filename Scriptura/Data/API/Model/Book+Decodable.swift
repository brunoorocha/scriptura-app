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
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        author = try container.decode(String.self, forKey: .author)
        numberOfChapters = try container.decode(Int.self, forKey: .numberOfChapters)
        group = try container.decode(String.self, forKey: .group)
        testament = try container.decode(String.self, forKey: .testament)
    }
}
