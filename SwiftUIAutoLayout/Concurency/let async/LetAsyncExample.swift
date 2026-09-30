//
//  ContentView.swift
//  sandbox
//
//  Created by Sergey Kozlov on 17.09.2026.
//

import SwiftUI

enum LetAsyncExample {
    struct ContentView: View {
        
        @StateObject var viewModel = ViewModel()
        var body: some View {
            VStack {
                List(viewModel.photos) { photo in
                    Image(uiImage: photo.image).resizable().scaledToFit()
                }
            }
            .task {
                try? await viewModel.loadAll()
            }
        }
    }
}

