//
//  APIChapterRepositoryTests.swift
//  ScripturaTests
//
//  Created by Bruno Rocha on 04/12/23.
//

import XCTest
@testable import Scriptura

final class APIChapterRepositoryTests: XCTestCase {
    var sut: APIChapterRepository!

    override func setUpWithError() throws {
        let mockConfiguration = URLSessionConfiguration.ephemeral
        mockConfiguration.protocolClasses = [MockURLProtocol.self]
        let service = APIService(configuration: mockConfiguration)
        sut = APIChapterRepository(service: service)
    }
    
    func testGetChapter_WhenRequest_ShouldRequestToVersesEndpoint() async throws {
        let expectation = XCTestExpectation(description: "It should request to /verses endpoint")
        let chapter = 1
        let book = Book.mock(named: "book")
        let version = "version"
        let expectedURL = "https://www.abibliadigital.com.br/api/verses/\(version)/\(book.abbreviation)/\(chapter)"
        var requestedURL: String?

        MockURLProtocol.requestHandler = { request in
            requestedURL = request.url?.absoluteString
            expectation.fulfill()
            return (.mockResponse(for: request, withCode: 200), Data())
        }
        
        let _ = try? await sut.getChapter(chapter, fromBook: book, version: version)
        
        XCTAssertEqual(requestedURL, expectedURL)
    }

    override func tearDownWithError() throws {
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = nil
    }

    func testGetChapter_WhenReturnsChapterResults_ShouldReturnChapterDecoded() async throws {
        let data = readJSONFile(named: "verses")!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse.mockResponse(for: request, withCode: 200)
            return (response, data)
        }
        let chapter = try await sut.getChapter(1, fromBook: .mock(named: "book"), version: "version")
        XCTAssertFalse(chapter.verses.isEmpty)
    }
}
