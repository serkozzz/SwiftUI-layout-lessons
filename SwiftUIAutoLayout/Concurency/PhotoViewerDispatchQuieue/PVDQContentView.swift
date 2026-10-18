//
//  sandbox3App.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 11.10.2026.
//

import SwiftUI


enum PhotoViewerDispatchQuieue {
    struct ContentView: View {
        
        @StateObject var colorsCollectionVM: ColorsCollectionViewModel
        private var colorsService: ColorsService
        
        init() {
            let colorsService = ColorsService()
            self.colorsService = colorsService
            _colorsCollectionVM = StateObject(wrappedValue: ColorsCollectionViewModel(colorsService: colorsService))
        }
        
        
        var body: some View {
            ColorsCollectionView(viewModel: colorsCollectionVM)
        }
    }
}
