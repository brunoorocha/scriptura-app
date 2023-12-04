//
//  MockChapterRepository.swift
//  Scriptura
//
//  Created by Bruno Rocha on 29/11/23.
//

import Foundation

struct MockChapterRepository: ChapterRepository {
    func getChapter(_ chapterNumber: Int, fromBook book: Book, version: String) async throws -> Chapter {
        return Chapter(
            book: "Gênesis",
            version: "nvi",
            number: 1,
            numberOfVerses: 31,
            verses: [
                Verse(number: 1, text: "No princípio Deus criou os céus e a terra."),
                Verse(number: 2, text: "Era a terra sem forma e vazia; trevas cobriam a face do abismo, e o Espírito de Deus se movia sobre a face das águas.")
            ]
        )
    }
}
