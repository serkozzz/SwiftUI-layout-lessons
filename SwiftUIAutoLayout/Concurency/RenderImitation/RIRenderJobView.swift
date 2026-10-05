//
//  RenderManagerView.swift
//  RenderImitation
//
//  Created by Sergey Kozlov on 05.10.2026.
//

import SwiftUI
import Combine

extension RenderImitation {
    struct RenderJobView : View {
        @ObservedObject var jobVM: RenderJobViewModel
        var body: some View {
            Group {
                if let image = jobVM.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                else {
                    Text("\(jobVM.progress)")
                }
            }
            .frame(width: 100, height: 100)
            
        }
    }
}
