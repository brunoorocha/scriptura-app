//
//  BooksViewModel.swift
//  Scriptura
//
//  Created by Bruno Rocha on 28/11/23.
//

import Combine

@MainActor
class BooksViewModel: ObservableObject {
    private let repository: BookRepository

    @Published var books = [BookListItem]()
    @Published var isLoading = false
    @Published var search = ""
    @Published var errorMessage: String?
    @Published var selectedBook: BookListItem?

    init(repository: BookRepository = APIBookRepository()) {
        self.repository = repository
    }

    func loadBooks() async {
        errorMessage = nil
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            books = try await repository.allBooks().map(BookListItem.fromDomainBook(_:))
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func didSelectBook(_ book: BookListItem) {
        selectedBook = selectedBook?.name == book.name ? nil : book
    }
    
    func didSelectChapter(_ chapter: Int) {
        selectedBook = selectedBook?.copyChanging(selectedChapter: chapter)
        books = books.map { book in
            book.copyChanging(
                selectedChapter: book.name == selectedBook?.name ? chapter : nil
            )
        }
    }
}

fileprivate extension BookListItem {
    func copyChanging(selectedChapter: Int? = nil) -> BookListItem {
        return .init(
            name: name,
            numberOfChapters: numberOfChapters,
            selectedChapter: selectedChapter
        )
    }
}
