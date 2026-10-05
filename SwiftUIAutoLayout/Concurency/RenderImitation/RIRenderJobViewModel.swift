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
    class RenderJobViewModel: ObservableObject, @MainActor Identifiable {
        private let job: RenderJob
        private let renderEngine: RenderEngine
        
        @Published var image: UIImage?
        @Published var progress: Double = 0
        private var task: Task<Void, Error>?
        
        init(job: RenderJob, renderEngine: RenderEngine) {
            self.job = job
            self.renderEngine = renderEngine
        }
        
        var id: UUID { job.id }
        
        func startRender() {
            self.task = Task {
                let stream = renderEngine.render(job)
                for try await event in stream {
                    switch event {
                    case .progress(let progress):
                        print("\(job.id): \(progress)")
                        self.progress = progress
                    case .complete(let image):
                        print("\(job.id): \(image.size)")
                        self.image = image
                    case .error(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        func cancelRender() {
            self.task?.cancel() 
        }
    }
}
