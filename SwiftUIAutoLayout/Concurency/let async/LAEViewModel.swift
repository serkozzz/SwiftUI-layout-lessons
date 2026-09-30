//
//  ViewModel.swift
//  sandbox
//
//  Created by Sergey Kozlov on 28.09.2026.
//

import SwiftUI
import Combine

extension LetAsyncExample {
    
    @MainActor
    class ViewModel: ObservableObject {
        let urls = ["https://showroom.calico.blackmana.com/resources-dev/icons//colors/369.png",
                    "https://showroom.calico.blackmana.com/resources-dev/icons//colors/370.png",
                    "https://showroom.calico.blackmana.com/resources-dev/icons//colors/371.png",
                    "https://showroom.calico.blackmana.com/resources-dev/icons//colors/372.png"
        ]
        
        @Published var photos = [Photo]()
        let serverAPI = ServerAPI()
        
        func loadAll() async throws  {
            async let first = serverAPI.getImage(urls[0])
            async let second = serverAPI.getImage(urls[1])
            async let third = serverAPI.getImage(urls[2])
            async let forth = serverAPI.getImage(urls[3])
            
            let (image0, image1, image2, image3) = await(try first, try second, try third, try forth)
            photos = [Photo(image: image0),
                      Photo(image: image1),
                      Photo(image: image2),
                      Photo(image: image3)]
        }
    }
    
    struct Photo: Identifiable {
        var id: UUID = UUID()
        var image: UIImage
    }
}
