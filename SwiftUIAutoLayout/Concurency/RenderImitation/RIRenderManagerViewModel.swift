//
//  RenderJobViewModel.swift
//  RenderImitation
//
//  Created by Sergey Kozlov on 05.10.2026.
//

import SwiftUI
import Combine

extension RenderImitation {
    @MainActor
    class RenderManagerViewModel: ObservableObject, Identifiable {
        
        @Published var jobVMs: [RenderJobViewModel] = []
        private var renderEngine: RenderEngine

        init(renderEngine: RenderEngine) {
            self.renderEngine = renderEngine
            self.jobVMs = [RenderJobViewModel(job: RenderJob(), renderEngine: renderEngine),
                           RenderJobViewModel(job: RenderJob(), renderEngine: renderEngine),
                           RenderJobViewModel(job: RenderJob(), renderEngine: renderEngine),
                           RenderJobViewModel(job: RenderJob(), renderEngine: renderEngine)]
        }
        
        func startRenders() {
            jobVMs.forEach { item in
                item.startRender()
            }
        }
        
        func cancelRenders() {
            jobVMs.forEach { item in
                item.cancelRender()
            }
        }
    }
}
