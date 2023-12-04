//
//  BooksViewModelTests.swift
//  ScripturaTests
//
//  Created by Bruno Rocha on 01/12/23.
//

import XCTest
@testable import Scriptura

extension Book {
    static func mock(named name: String) -> Book {
        .init(name: name, author: "Moisés", numberOfChapters: 50, group: "Pentatêuco", testament: "VT", abbreviation: "gn")
    }
}

final class SpyBookRepository: BookRepository {
    func allBooks() async throws -> [Scriptura.Book] {
        return []
    }
}

final class BooksViewModelTests: XCTestCase {
    var sut: BooksViewModel!
    var spyRepository: SpyBookRepository!
    
    override func setUpWithError() throws {
        spyRepository = SpyBookRepository()
    }
    
    @MainActor
    func testChapterSelection_WhenSelectBook_ShouldSetSelectedBook() {
        let bookItem = BookListItem.fromDomainBook(.mock(named: "Gênesis"))
        sut = BooksViewModel(repository: spyRepository)
        sut.books = [bookItem]

        sut.didSelectBook(bookItem)
        
        XCTAssertEqual(sut.selectedBook?.id, bookItem.id)
    }
    
    @MainActor
    func testChapterSelection_WhenSelectTheSameBookTwice_ShouldSetSelectedBookAsNil() {
        let bookItem = BookListItem.fromDomainBook(.mock(named: "Gênesis"))
        sut = BooksViewModel(repository: spyRepository)
        sut.books = [bookItem]

        sut.didSelectBook(bookItem)
        sut.didSelectBook(bookItem)
        
        XCTAssertNil(sut.selectedBook)
    }
    
    @MainActor
    func testChapterSelection_WhenSelectChapter_ShouldSetSelectedChapterFromBook() {
        let bookItem = BookListItem.fromDomainBook(.mock(named: "Gênesis"))
        let chapter = 1

        sut = BooksViewModel(repository: spyRepository)
        sut.books = [bookItem]

        sut.didSelectBook(bookItem)
        sut.didSelectChapter(chapter)
        
        XCTAssertEqual(sut.books.first!.selectedChapter, chapter)
    }
    
    @MainActor
    func testChapterSelection_WhenSelectChapter_ShouldSetSelectedChapterFromOtherBooksAsNil() {
        let chapter = 1

        sut = BooksViewModel(repository: spyRepository)
        sut.books = [
            .fromDomainBook(.mock(named: "Gênesis")),
            .fromDomainBook(.mock(named: "Êxodo")),
            .fromDomainBook(.mock(named: "Levítico"))
        ]

        sut.didSelectBook(sut.books.first!)
        sut.didSelectChapter(chapter)
        
        XCTAssertEqual(sut.books[0].selectedChapter, chapter)
        XCTAssertNil(sut.books[1].selectedChapter)
        XCTAssertNil(sut.books[2].selectedChapter)
    }
}
