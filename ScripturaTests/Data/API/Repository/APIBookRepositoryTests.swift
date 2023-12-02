//
//  APIBookRepositoryTests.swift
//  ScripturaTests
//
//  Created by Bruno Rocha on 29/11/23.
//

import XCTest
@testable import Scriptura

final class APIBookRepositoryTests: XCTestCase {
    var sut: APIBookRepository!

    override func setUpWithError() throws {
        let mockConfiguration = URLSessionConfiguration.ephemeral
        mockConfiguration.protocolClasses = [MockURLProtocol.self]
        let service = APIService(configuration: mockConfiguration)
        sut = APIBookRepository(service: service)
    }

    override func tearDownWithError() throws {
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = nil
    }
    
    func testAllBooks_WhenRequest_ShouldRequestToBooksEndpoint() async throws {
        let expectation = XCTestExpectation(description: "It should request to /books endpoint")
        var requestedURL: String?

        MockURLProtocol.requestHandler = { request in
            requestedURL = request.url?.absoluteString
            expectation.fulfill()
            return (.mockResponse(for: request, withCode: 200), Data())
        }
        
        let _ = try? await sut.allBooks()
        
        XCTAssertEqual(requestedURL, "https://www.abibliadigital.com.br/api/books")
    }

    func testAllBooks_WhenAPIReturnsBooksResults_ShouldReturnBooksDecoded() async throws {
        let data = readJSONFile(named: "books")
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse.mockResponse(for: request, withCode: 200)
            return (response, data!)
        }
        let books = try await sut.allBooks()
        XCTAssertFalse(books.isEmpty)
    }
}
