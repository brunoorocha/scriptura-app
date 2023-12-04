//
//  ChapterRepository.swift
//  Scriptura
//
//  Created by Bruno Rocha on 29/11/23.
//

import Foundation

protocol ChapterRepository {
    func getChapter(_ chapterNumber: Int, fromBook book: Book, version: String) async throws -> Chapter
}
