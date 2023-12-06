//
//  ReaderViewModel.swift
//  Scriptura
//
//  Created by Bruno Rocha on 29/11/23.
//

import Combine

@MainActor
class ReaderViewModel: ObservableObject {
    private let chapterRepository: ChapterRepository
    private let bookRepository: BookRepository

    @Published var isSelectingChapter = false
    @Published var isChangingReaderSettings = false
    @Published var verses = [ReaderVerseItem]()

    var headerText: String {
        guard let currentBook = currentBook, let currentChapter = currentChapter else {
            return ""
        }
        return "\(currentBook.name) \(currentChapter)"
    }
    
    var currentChapter: Int?
    var currentBook: Book?
    
    init(chapterRepository: ChapterRepository, bookRepository: BookRepository) {
        self.chapterRepository = chapterRepository
        self.bookRepository = bookRepository
    }
    
    func loadFromLastRead() async {
        await setChapter(49, fromBook: "Gênesis")
    }
    
    func didSelectChapter(_ chapterNumber: Int, fromBook book: String) async {
        isSelectingChapter = false
        await setChapter(chapterNumber, fromBook: book)
    }
    
    func goToNextChapter() {
        guard let currentChapter = currentChapter, let currentBook = currentBook else { return }
        let nextChapter = currentChapter + 1
        if nextChapter <= 0 || nextChapter > currentBook.numberOfChapters { return }
        Task {
            await setChapter(nextChapter, fromBook: currentBook.name)
        }
    }
    
    func goToPreviousChapter() {
        guard let currentChapter = currentChapter, let currentBook = currentBook else { return }
        let previousChapter = currentChapter - 1
        if previousChapter <= 0 || previousChapter > currentBook.numberOfChapters { return }
        Task {
            await setChapter(previousChapter, fromBook: currentBook.name)
        }
    }
    
    private func setChapter(_ chapterNumber: Int, fromBook book: String) async {
        do {
            guard let bookModel = await bookNamed(book) else { return }
            let chapter = try await chapterRepository.getChapter(chapterNumber, fromBook: bookModel, version: "nvi")
            verses = chapter.verses.map(ReaderVerseItem.fromDomainVerse(_:))
            currentBook = bookModel
            currentChapter = chapterNumber
        } catch {
            print(error)
        }
    }
    
    private func bookNamed(_ name: String) async -> Book? {
        do {
            let books = try await bookRepository.allBooks()
            return books.first(where: { $0.name == name })
        } catch {
            print(error)
            return nil
        }
    }
}
