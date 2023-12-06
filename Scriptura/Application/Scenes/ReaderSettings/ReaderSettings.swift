//
//  ReaderSettings.swift
//  Scriptura
//
//  Created by Bruno Rocha on 05/12/23.
//

import Foundation

struct ReaderSettings {
    var paragraphFontSize: CGFloat

    var titleFontSize: CGFloat {
        paragraphFontSize * 1.6
    }

    var verseFontSize: CGFloat {
        paragraphFontSize * 0.7
    }

    var paragraphLineSpacing: CGFloat {
        paragraphFontSize * 0.4
    }
    
    var paragraphSpacing: CGFloat {
        paragraphFontSize * 0.3
    }
}
