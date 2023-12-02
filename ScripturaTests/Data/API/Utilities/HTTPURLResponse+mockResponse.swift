//
//  HTTPURLResponse+mockResponse.swift
//  ScripturaTests
//
//  Created by Bruno Rocha on 29/11/23.
//

import Foundation

extension HTTPURLResponse {
    static func mockResponse(for request: URLRequest, withCode statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: ["Content-type" : "application/json"])!
    }
}
