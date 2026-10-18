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
                
                let image = try await picturesService.getIcon(for: dto)
                guard let thumbnail = await image.byPreparingThumbnail(
                    ofSize: CGSize(width: 800, height: 600)) else {
                        throw ServerAPIError.invalidBodyData
                    }
                self.image = thumbnail
            }
            catch {
                
            }
        }
    }
}
