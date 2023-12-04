//
//  VersesAPIRequest.swift
//  Scriptura
//
//  Created by Bruno Rocha on 02/12/23.
//

import Foundation

struct VersesAPIRequest: APIRequest {
    var baseURL = "https://www.abibliadigital.com.br"
    var endpoint: String {
        "/api/verses/\(version)/\(bookAbbreviation)/\(chapter)"
    }

    let version: String
    let bookAbbreviation: String
    let chapter: Int
}

extension APIRequest where Self == VersesAPIRequest {
    static func verses(ofChapter chapter: Int, fromBook bookAbbreviation: String, version: String) -> Self {
        return VersesAPIRequest(version: version, bookAbbreviation: bookAbbreviation, chapter: chapter)
    }
}
