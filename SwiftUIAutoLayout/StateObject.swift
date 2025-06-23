//
//  StateObject.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 18.06.2025.
//

import SwiftUI

struct StateObjectExample: View {
    @State private var showPhotos = false
    @State private var index = 1
    
    var body: some View {
        VStack {
            Stepper("index", value: $index)
                .fixedSize()
            
            Spacer()
            Button("Toggle") { showPhotos.toggle() }
                .buttonStyle(.borderedProminent)
            if showPhotos {
                MyView(index: index)
                    .onAppear {
                        print("onAppear")
                    }
            }
            Spacer()
        }
    }
}


private struct MyView: View {
    @ObservedObject var viewModel = ViewModel() // или @StateObject
    var index: Int
    var body: some View {
        Text("MyView. index = \(index)")
    }
}

private class ViewModel: ObservableObject {
    init() {
        print("ViewModel initialized, id: \(Unmanaged.passUnretained(self).toOpaque())")
    }
}

#Preview {
    StateObjectExample()
}


