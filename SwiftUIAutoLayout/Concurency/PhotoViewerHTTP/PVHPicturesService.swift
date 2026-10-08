//
//  PicturesService.swift
//  PicturesViewerFromBook
//
//  Created by Sergey Kozlov on 23.09.2026.
//

import SwiftUI


extension PhotoViewerHTTPWithTasksQueue {
    @MainActor
    class PicturesService {
        private let serverAPI = ServerAPI()
        
        private var picturesList: [PictureDTO]?
        
        private var iconsCache: [String: UIImage] = [:]
        private var picturesCache: [String: UIImage] = [:]
        
        private var activeTasks: [String: Task<UIImage, Error>] = [:]
        
        func getIcon(for picture: PictureDTO) async throws -> UIImage {
            guard iconsCache[picture.id] == nil else {
                return iconsCache[picture.id]!
            }
            
            if activeTasks[picture.id] == nil {
                activeTasks[picture.id] = Task {
                    defer {
                        activeTasks[picture.id] = nil
                    }
                    iconsCache[picture.id] = try await serverAPI.getImage(picture.download_url)
                    return iconsCache[picture.id]!
                }
            }
            
            let activeTask = activeTasks[picture.id]!
            let image = try await activeTask.value
            return image
        }
    }
}
