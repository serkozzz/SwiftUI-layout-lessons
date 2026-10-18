//
//  ColorView.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 17.10.2026.
//

import SwiftUI


extension PhotoViewerDispatchQuieue {
    struct ColorView: View {
        @State var image: UIImage?
        var colorDTO: ColorDTO
        var colorsService: ColorsService
        
        var body: some View {
            Group {
                if let image {
                    Image(uiImage: image).resizable().aspectRatio(contentMode: .fit)
                }
                else {
                    ProgressView()
                }
            }
            .onAppear() {
                colorsService.getImage(for: colorDTO) { result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            self.image = image
                        }
                        
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
