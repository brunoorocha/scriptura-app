//
//  ReaderView.swift
//  Scriptura
//
//  Created by Bruno Rocha on 28/11/23.
//

import SwiftUI

struct ReaderView: View {
    @StateObject var viewModel: ReaderViewModel
    @StateObject var readerSettings: ReaderSettingsViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(viewModel.headerText)
                        .font(AppFonts.Merriweather.black(size: 32).font)
                        .padding(.vertical, 40)

                    ForEach(viewModel.verses) { verse in
                        HStack(alignment: .top) {
                            Text(verse.number)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(verse.text)
                                .font(AppFonts.Merriweather.light(size: readerSettings.fontSize).font)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button {
                        viewModel.isSelectingChapter = true
                    } label: {
                        Label(viewModel.headerText, systemImage: "chevron.down")
                            .foregroundColor(.primary)
                            .labelStyle(.iconAtRight)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.isChangingReaderSettings = true
                    } label: {
                        Label("", systemImage: "textformat")
                            .foregroundColor(.primary)
                            .labelStyle(.iconOnly)
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadFromLastRead()
                }
            }
            .sheet(isPresented: $viewModel.isSelectingChapter) {
                BooksView(
                    viewModel: BooksViewModel(repository: APIBookRepository()),
                    onSelect: { bookName, chapter in
                        Task {
                            await viewModel.didSelectChapter(chapter, fromBook: bookName)
                        }
                    },
                    onCancel: {
                        viewModel.isSelectingChapter = false
                    }
                )
            }
            .sheet(isPresented: $viewModel.isChangingReaderSettings) {
                ReaderSettingsView(viewModel: readerSettings)
                    .presentationDetents([
                        .fraction(0.2),
                    ])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView(
            viewModel:
                ReaderViewModel(
                    chapterRepository: MockChapterRepository(),
                    bookRepository: MockBooksRepository()
                ),
            readerSettings: ReaderSettingsViewModel()
        )
    }
}
