//
//  InvertedIconLabel.swift
//  Scriptura
//
//  Created by Bruno Rocha on 05/12/23.
//

import SwiftUI

struct InvertedIconLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
                .imageScale(.small)
        }
    }
}

extension LabelStyle where Self == InvertedIconLabel {
    static var iconAtRight: Self { InvertedIconLabel() }
}

