//
//  RenderManagerViewModel.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 22.10.2026.
//

import SwiftUI
import Combine

extension RenderImitationGCD {
    
    @MainActor
    class RenderManagerViewModel : ObservableObject {
        @Published var jobs: [RenderJob] = []
        @Published var error: Error?
        let renderEngine: RenderEngine
        
        init(renderEngine:RenderEngine) {
            self.renderEngine = renderEngine
        }
        
        func addJob() {
            let job = RenderJob()
            jobs.append(job)
            renderEngine.startRender(onProgress: { [weak self] progress in
                DispatchQueue.main.async {[weak self]  in
                    guard let self else { return }
                    guard let index = jobs.firstIndex(where: {job.id == $0.id}) else { return }
                    jobs[index].progress = progress
                }
            },
                                     completion: { [weak self] result in
                DispatchQueue.main.async {[weak self]  in
                    guard let self else { return }
                    guard let index = jobs.firstIndex(where: {job.id == $0.id}) else { return }
                    switch result {
                    case .success(let image):
                        jobs[index].image = image
                    case .failure(let error):
                        self.error = error
                    }
                }
            })
        }
    }
}
