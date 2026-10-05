//
//  RenderManagerView.swift
//  RenderImitation
//
//  Created by Sergey Kozlov on 05.10.2026.
//

import SwiftUI
import Combine

enum RenderImitation {
    struct RenderManagerView : View {
        
        @StateObject var viewModel: RenderManagerViewModel
        
        init(renderEngine: RenderEngine) {
            self._viewModel = StateObject(wrappedValue: RenderManagerViewModel(renderEngine: renderEngine))
        }
        
        var body: some View {
            VStack {
                Button("start") {
                    viewModel.jobVMs.forEach { item in
                        Task {
                            try await item.startRender()
                        }
                    }
                }
                List(viewModel.jobVMs) { jobVM in
                    RenderJobView(jobVM: jobVM)
                }
            }
        }
    }
}
