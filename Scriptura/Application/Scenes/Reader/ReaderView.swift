//
//  ReaderView.swift
//  Scriptura
//
//  Created by Bruno Rocha on 28/11/23.
//

import SwiftUI

struct ReaderView: View {
    @StateObject var viewModel: ReaderViewModel
    @EnvironmentObject var readerSettings: ReaderSettingsViewModel
    @State var viewXOffset = CGFloat.zero

    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    HStack {
                        Label("", systemImage: "chevron.left")
                            .offset(x: 4)
                            .frame(width: 40, height: 40)
                            .background(Color.primary.opacity(0.1))
                            .cornerRadius(40)
                            .fontWeight(.medium)
                            .offset(x: viewXOffset >= 0 ? viewXOffset * 0.2 : .zero)
                            .opacity(viewXOffset >= 0 ? viewXOffset / 50 : .zero)
                            .animation(.easeOut, value: viewXOffset)
                        Spacer()
                        Label("", systemImage: "chevron.right")
                            .offset(x: 4)
                            .frame(width: 40, height: 40)
                            .background(Color.primary.opacity(0.1))
                            .cornerRadius(40)
                            .fontWeight(.medium)
                            .offset(x: viewXOffset <= 0 ? viewXOffset * 0.2 : .zero)
                            .opacity(viewXOffset <= 0 ? (abs(viewXOffset) / CGFloat(50)) : .zero)
                            .animation(.easeOut, value: viewXOffset)
                    }

                    VStack {
                        Text(viewModel.headerText)
                            .font(AppFonts.Merriweather.black(size: readerSettings.settings.titleFontSize).font)
                            .padding(.vertical, readerSettings.settings.titleFontSize)
                        
                        ForEach(viewModel.verses) { verse in
                            HStack(alignment: .top) {
                                Text(verse.number)
                                    .font(AppFonts.Merriweather.light(size: readerSettings.settings.verseFontSize).font)
                                    .foregroundColor(.gray)
                                Text(verse.text)
                                    .font(AppFonts.Merriweather.light(size: readerSettings.settings.paragraphFontSize).font)
                                    .lineSpacing(readerSettings.settings.paragraphSpacing)
                                    .padding(.bottom, readerSettings.settings.paragraphSpacing)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding()
                    .offset(x: viewXOffset)
                    .animation(.easeOut, value: viewXOffset)
                }
            }
            .gesture(dragGesture)
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
                ReaderSettingsView()
                    .presentationDetents([
                        .fraction(0.2),
                    ])
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged {
                onDragGestureChange(translation: $0.translation)
            }
            .onEnded {
                onDragGestureEnd(translation: $0.translation)
            }
    }
    
    func onDragGestureChange(translation: CGSize) {
        let maxXOffset = CGFloat(50)
        if translation.width < 0 {
            let value = max(translation.width, (maxXOffset * -1))
            viewXOffset = value
            return
        }
        let value = min(translation.width, maxXOffset)
        viewXOffset = value
    }
    
    func onDragGestureEnd(translation: CGSize) {
        viewXOffset = .zero
        if translation.width >= 50 {
            viewModel.goToPreviousChapter()
            return
        }
        if translation.width <= -50 {
            viewModel.goToNextChapter()
            return
        }
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReaderView(
                viewModel:
                    ReaderViewModel(
                        chapterRepository: MockChapterRepository(),
                        bookRepository: MockBooksRepository()
                    )
            )
            .environmentObject(ReaderSettingsViewModel())
            
            ReaderView(
                viewModel:
                    ReaderViewModel(
                        chapterRepository: MockChapterRepository(),
                        bookRepository: MockBooksRepository()
                    )
            )
            .preferredColorScheme(.dark)
            .environmentObject(ReaderSettingsViewModel())
        }
    }
}
