//
//  ReaderView.swift
//  Scriptura
//
//  Created by Bruno Rocha on 28/11/23.
//

import SwiftUI

struct ReaderView: View {
    @StateObject var viewModel: ReaderViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Button(action: {
                        viewModel.selectChapter()
                    }, label: {
                        Label(viewModel.headerText, systemImage: "")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    })
                    .padding(.vertical, 40)

                    ForEach(viewModel.verses) { verse in
                        HStack {
                            Text(verse.number)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(verse.text)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            .onAppear {
                Task {
                    await viewModel.loadFromLastRead()
                }
            }
            .sheet(isPresented: $viewModel.isSelectingChapter) {
                BooksView(
                    viewModel: BooksViewModel(repository: MockBooksRepository()),
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
        }
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView(viewModel: ReaderViewModel(chapterRepository: MockChapterRepository(), bookRepository: MockBooksRepository()))
    }
}
