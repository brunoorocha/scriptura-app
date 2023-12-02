//
//  BooksAPIRequest.swift
//  Scriptura
//
//  Created by Bruno Rocha on 29/11/23.
//

import Foundation

struct BooksAPIRequest: APIRequest {
    var baseURL = "https://www.abibliadigital.com.br"
    var endpoint = "/api/books"
}

extension APIRequest where Self == BooksAPIRequest {
    static var books: Self { .init() }
}
