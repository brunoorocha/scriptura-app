//
//  AppFonts.swift
//  Scriptura
//
//  Created by Bruno Rocha on 04/12/23.
//

import Foundation
import SwiftUI

protocol AppFont {
    var font: Font { get }
}

enum AppFonts {
    enum Merriweather: AppFont {
        case light(size: CGFloat)
        case regular(size: CGFloat)
        case black(size: CGFloat)
        
        var font: Font {
            switch(self) {
            case .light(let size):
                return .custom("Merriweather-Light", size: size)
            case .regular(let size):
                return .custom("Merriweather-Regular", size: size)
            case .black(let size):
                return .custom("Merriweather-Black", size: size)
            }
        }
    }
}
