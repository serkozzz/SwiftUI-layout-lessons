//
//  ViewModel.swift
//  sandbox
//
//  Created by Sergey Kozlov on 28.09.2026.
//

import SwiftUI
import Combine

extension TaskGroupExample {
    
    @MainActor
    class ViewModel: ObservableObject {
        let urls = ["https://showroom.calico.blackmana.com/resources-dev/icons//colors/369.png",
                    "wrong_url",
                    "https://showroom.calico.blackmana.com/resources-dev/icons//colors/370.png",
                    "https://showroom.calico.blackmana.com/resources-dev/icons//colors/371.png",
                    "https://showroom.calico.blackmana.com/resources-dev/icons//colors/372.png"
        ]
        
        @Published var photos = [Photo]()
        let serverAPI = ServerAPI()
        
        func loadAll() async throws  {
            try await withThrowingTaskGroup { group in
                for url in urls {
                    group.addTask { [serverAPI] in
                        do {
                            return try await serverAPI.getImage(url)
                        }
                        catch let error as ServerAPIError {
                            if (error == .cancellation) {
                                print ("cancellation")
                            }
                            throw error
                        }
                        catch {
                            throw error
                        }
                        
                    }
                    //await counter.increment()
                }
                
                
                // Перебираем результаты
                for try await result in group {
                    photos.append(Photo(image: result))
                }
            }
        }
    }
    
    struct Photo: Identifiable {
        var id: UUID = UUID()
        var image: UIImage
    }
}
