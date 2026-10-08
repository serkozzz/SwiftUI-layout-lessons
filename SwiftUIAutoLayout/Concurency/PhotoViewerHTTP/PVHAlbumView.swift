//
//  AlbumView.swift
//  sandbox2
//
//  Created by Sergey Kozlov on 08.10.2026.
//

import SwiftUI


extension PhotoViewerHTTPWithTasksQueue {
    
    @MainActor
    struct AlbumView: View {
        @StateObject var albumVM = AlbumViewModel()
        
        var body: some View {
            List(albumVM.photos) { photo in
                PhotoView(dto: photo, picturesService: albumVM.picturesService)
            }
            .task {
                await albumVM.loadPhotosList()
            }
        }
    }
}
