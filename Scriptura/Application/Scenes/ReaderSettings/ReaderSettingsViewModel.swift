//
//  ReaderSettingsViewModel.swift
//  Scriptura
//
//  Created by Bruno Rocha on 05/12/23.
//

import Foundation

class ReaderSettingsViewModel: ObservableObject {
    @Published var fontSize: CGFloat
    
    init(fontSize: CGFloat = 16) {
        self.fontSize = fontSize
    }
}
