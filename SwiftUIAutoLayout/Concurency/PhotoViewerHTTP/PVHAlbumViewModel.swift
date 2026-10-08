//
//  AlbumViewModel.swift
//  sandbox2
//
//  Created by Sergey Kozlov on 08.10.2026.
//

import SwiftUI
import Combine


extension PhotoViewerHTTPWithTasksQueue {
    
    @MainActor
    class AlbumViewModel: ObservableObject {
        @Published var photos: [PictureDTO] = []
        @Published var errorMessage: String?
        
        var picturesService = PicturesService()
        
        func loadPhotosList() async {
            do {
                let list: [PictureDTO] = try await ServerAPI().getJSON(ServerAPI.endpoint)
                photos = list
            }
            catch {
                errorMessage = error.localizedDescription
            }
        }
        
    }
}
