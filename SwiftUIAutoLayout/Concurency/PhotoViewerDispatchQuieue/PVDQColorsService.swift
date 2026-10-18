//
//  ColorsService.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 17.10.2026.
//

import SwiftUI


extension PhotoViewerDispatchQuieue {
    class ColorsService {
        private var imagesCache: [Int: UIImage] = [:]
        private var serverAPI = ServerAPI()
        //private var imageTasks = [Int: Task<Void, Error>]()
        private var completionsMap = [Int: [(Result<UIImage, Error>) -> Void]]()
        private let serialQueue = DispatchQueue(label: "colors.images.state")
        
        
        func getColors(completion: @escaping (Result<[ColorDTO], Error>) -> Void) {
            serverAPI.sendJSONRequest(urlString: ServerAPI.endpoint, completion: completion)
        }
        
        func getImage(for colorDTO: ColorDTO, completion: @escaping (Result<UIImage, Error>) -> Void){
            
            serialQueue.async { [weak self] in
                guard let self else { return }
                
                if let cached = self.imagesCache[colorDTO.id] {
                    completion(.success(cached))
                    return
                }
                
                if (completionsMap[colorDTO.id] == nil) {
                    completionsMap[colorDTO.id] = [completion]
                    serverAPI.sendImageRequest(urlString: colorDTO.icon) { [weak self] result in
                        guard let self else { return }
                        serialQueue.async { [weak self] in
                            guard let self else { return }
                            switch result {
                            case .success(let image):
                                imagesCache[colorDTO.id] = image
                                completionsMap[colorDTO.id]!.forEach { completionFromMap in
                                    completionFromMap(.success(image))
                                }
                                
                                
                            case .failure(let error):
                                completionsMap[colorDTO.id]!.forEach { completionFromMap in
                                    completionFromMap(.failure(error))
                                }
                            }
                            completionsMap[colorDTO.id] = nil
                        }
                    }
                }
                else {
                    completionsMap[colorDTO.id]?.append(completion)
                }
            }
        }
    }
}
