//
//  BooksView.swift
//  Scriptura
//
//  Created by Bruno Rocha on 28/11/23.
//

import SwiftUI

struct BooksView: View {
    @StateObject var viewModel: BooksViewModel

    var onSelect: ((String, Int) -> Void)?
    
    var onCancel: (() -> Void)?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 40)
                            .padding(.top, 40)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Button(action: {
                            Task {
                                await viewModel.loadBooks()
                            }
                        }, label: {
                            Label("Tentar de novo", systemImage: "")
                        })
                    }

                    ForEach(viewModel.books) { book in
                        BookListItemView(
                            book: book,
                            isCollapsed: viewModel.selectedBook?.name != book.name,
                            didSelectBook: { book in
                                viewModel.didSelectBook(book)
                            },
                            didSelectChapter: { chapter in
                                viewModel.didSelectChapter(chapter)
                                onSelect?(book.name, chapter)
                            }
                        )
                    }
                }
            }
            .navigationTitle("Livros")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.search)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {                
                    Button(action: {
                        onCancel?()
                    }, label: {
                        Label("Cancelar", systemImage: "")
                            .labelStyle(.titleOnly)
                    })
                }

            }
        }
        .onAppear {
            Task {
                await viewModel.loadBooks()
            }
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView(viewModel: BooksViewModel(repository: MockBooksRepository()))
    }
}
