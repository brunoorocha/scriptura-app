//
//  ScripturaApp.swift
//  Scriptura
//
//  Created by Bruno Rocha on 28/11/23.
//

import SwiftUI

@main
struct ScripturaApp: App {
    var body: some Scene {
        WindowGroup {
            ReaderView(
                viewModel: ReaderViewModel(
                    chapterRepository: APIChapterRepository(),
                    bookRepository: APIBookRepository()
                )
            )
            .environmentObject(ReaderSettingsViewModel())
        }
    }
}
