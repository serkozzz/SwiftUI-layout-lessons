//
//  StateObject.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 18.06.2025.
//

import SwiftUI

struct StateObjectExample: View {
    @State private var showPhotos = false
    
    var body: some View {
        VStack {
            Button("Toggle Photos") { showPhotos.toggle() }
            if showPhotos {
                PhotosListView()
            }
        }
    }
}

struct PhotosListView: View {
    @StateObject var viewModel = PhotosListViewModel() // или @StateObject
    
    var body: some View {
        Text("PhotosListView")
    }
}

class PhotosListViewModel: ObservableObject {
    init() {
        print("ViewModel initialized, id: \(Unmanaged.passUnretained(self).toOpaque())")
    }
}

#Preview {
    StateObjectExample()
}
