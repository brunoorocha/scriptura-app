//
//  ReaderSettingsViewModel.swift
//  Scriptura
//
//  Created by Bruno Rocha on 05/12/23.
//

import Foundation

class ReaderSettingsViewModel: ObservableObject {
    @Published var settings: ReaderSettings
    
    init() {
        self.settings = ReaderSettings(paragraphFontSize: 16)
    }
}
