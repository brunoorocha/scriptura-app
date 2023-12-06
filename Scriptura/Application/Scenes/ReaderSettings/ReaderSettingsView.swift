//
//  ReaderSettingsView.swift
//  Scriptura
//
//  Created by Bruno Rocha on 05/12/23.
//

import SwiftUI

struct ReaderSettingsView: View {
    @EnvironmentObject var viewModel: ReaderSettingsViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Tamanho da fonte")
                    .font(.headline)
                Slider(
                    value: $viewModel.settings.paragraphFontSize,
                    in: (12...32),
                    step: 2,
                    label: {
                        Text("Tamanho da fonte")
                    },
                    minimumValueLabel: {
                        Text("A")
                            .font(.system(size: 12))
                    },
                    maximumValueLabel: {
                        Text("A")
                            .font(.system(size: 32))
                    }
                )
            }
            .padding()
            .navigationTitle("Configurações de leitura")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ReaderSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderSettingsView()
            .environmentObject(ReaderSettingsViewModel())
    }
}
