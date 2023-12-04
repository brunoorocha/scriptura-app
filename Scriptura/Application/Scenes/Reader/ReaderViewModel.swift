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
    @Published var headerText = "Gênesis 1"
    @Published var verses = [ReaderVerseItem]()
    
    init(chapterRepository: ChapterRepository, bookRepository: BookRepository) {
        self.chapterRepository = chapterRepository
        self.bookRepository = bookRepository
    }
    
    func loadFromLastRead() async {
        await setChapter(1, fromBook: "Gênesis")
    }
    
    func selectChapter() {
        isSelectingChapter = true
    }
    
    func didSelectChapter(_ chapterNumber: Int, fromBook book: String) async {
        isSelectingChapter = false
        await setChapter(chapterNumber, fromBook: book)
    }
    
    private func setChapter(_ chapterNumber: Int, fromBook book: String) async {
        do {
            guard let bookModel = await bookNamed(book) else { return }
            let chapter = try await chapterRepository.getChapter(chapterNumber, fromBook: bookModel, version: "nvi")
            verses = chapter.verses.map(ReaderVerseItem.fromDomainVerse(_:))
            headerText = "\(book) \(chapterNumber)"
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
