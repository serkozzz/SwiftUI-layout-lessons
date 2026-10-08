//
//  PhotoView.swift
//  sandbox2
//
//  Created by Sergey Kozlov on 08.10.2026.
//

import SwiftUI


extension PhotoViewerHTTPWithTasksQueue {
    struct PhotoView: View {
        var dto: PictureDTO
        @State var image: UIImage?
        var picturesService: PicturesService
        var body: some View {
            Group {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                else {
                    ProgressView()
                }
            }
            .task {
                await loadIcon()
            }
        }
        
        func loadIcon() async {
            do {
                print("PhotoView.task")
                
                image = try await picturesService.getIcon(for: dto)
            }
            catch {
                
            }
        }
    }
}
