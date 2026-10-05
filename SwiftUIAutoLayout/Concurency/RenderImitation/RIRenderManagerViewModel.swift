//
//  RenderJobViewModel.swift
//  RenderImitation
//
//  Created by Sergey Kozlov on 05.10.2026.
//

import SwiftUI
import Combine

extension RenderImitation {
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
    }
}
