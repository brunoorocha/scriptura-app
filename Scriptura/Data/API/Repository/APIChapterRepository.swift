//
//  APIChapterRepository.swift
//  Scriptura
//
//  Created by Bruno Rocha on 02/12/23.
//

import Foundation

final class APIChapterRepository: ChapterRepository {
    private let service: APIService
    
    init(service: APIService = APIService()) {
        self.service = service
    }
    
    func getChapter(_ chapterNumber: Int, fromBook book: Book, version: String) async throws -> Chapter {
        return try await service.request(
            .verses(
                ofChapter: chapterNumber,
                fromBook: book.abbreviation,
                version: version
            )
        )
    }
}
