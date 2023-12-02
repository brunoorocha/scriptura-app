//
//  BookListItemView.swift
//  Scriptura
//
//  Created by Bruno Rocha on 30/11/23.
//

import SwiftUI

struct BookListItemView: View {
    @State var book: BookListItem
    
    var isCollapsed = true

    var didSelectBook: (BookListItem) -> Void

    var didSelectChapter: (Int) -> Void
    
    let columns = [GridItem(.adaptive(minimum: 50, maximum: .infinity))]
    
    var backgroundColor: Color {
        isCollapsed ? Color.gray.opacity(0) : Color.gray.opacity(0.1)
    }
    
    let chapterBackground = Color.gray.opacity(0.1)
    let selectedChapterBackground = Color.gray.opacity(0.4)
    
    var iconName: String {
        isCollapsed ? "chevron.down" : "chevron.up"
    }

    var body: some View {
        VStack {
            HStack {
                Text(book.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Label("", systemImage: iconName)
            }
            .padding(16)
            .onTapGesture {
                didSelectBook(book)
            }

            if !isCollapsed {
                LazyVGrid(columns: columns, spacing: 6) {
                    ForEach(1...book.numberOfChapters, id: \.self) { chapter in
                        Button(action: {
                            didSelectChapter(chapter)
                        }, label: {
                            Text(String(chapter))
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(book.selectedChapter == chapter ? selectedChapterBackground : chapterBackground)
                                .foregroundColor(.primary)
                                .cornerRadius(8)
                        })
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .background(backgroundColor)
    }
}

struct BookListItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BookListItemView(
                book: .init(name: "Gênesis", numberOfChapters: 50, selectedChapter: 10),
                isCollapsed: false,
                didSelectBook: { _ in },
                didSelectChapter: { _ in }
            )
            BookListItemView(
                book: .init(name: "Êxodo", numberOfChapters: 40),
                didSelectBook: { _ in },
                didSelectChapter: { _ in }
            )
        }
    }
}
