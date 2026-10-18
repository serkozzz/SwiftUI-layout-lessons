//
//  ContentView.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 11.10.2026.
//

import SwiftUI

extension PhotoViewerDispatchQuieue {
    struct ColorsCollectionView: View {
        @ObservedObject var viewModel: ColorsCollectionViewModel
        
        let columns = [ GridItem(.adaptive(minimum: 250, maximum: 400))]
        
        var body: some View {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.colors) { color in
                        ColorView(colorDTO: color, colorsService: viewModel.colorsService)
                    }
                }
            }
            .onAppear() {
                viewModel.loadColors()
            }
        }
    }
}


