//
//  RenderJobView.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 21.10.2026.
//

import SwiftUI

extension RenderImitationWithCancellation {
    struct RenderJobView: View {
        var renderJob: RenderJob
        var body: some View {
            if let image = renderJob.image {
                Image(uiImage: image).resizable().aspectRatio(contentMode: .fit)
            }
            else {
                VStack {
                    ProgressView()
                    Text("\(renderJob.progress) / 1.0")
                }
            }
        }
    }
}
