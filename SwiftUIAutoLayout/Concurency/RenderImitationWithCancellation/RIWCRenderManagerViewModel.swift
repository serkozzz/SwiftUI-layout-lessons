//
//  RenderManagerViewModel.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 21.10.2026.
//

import SwiftUI
import Combine

extension RenderImitationWithCancellation {
    @MainActor
    class RenderManagerViewModel: ObservableObject {
        
        @Published var jobs: [RenderJob] = []
        @Published var error: Error?
        
        
        private var renderEngine: RenderEngine
        private var idToTaskMap =  [UUID: Task<(), Error>]()
        init(renderEngine: RenderEngine) {
            self.renderEngine = renderEngine
        }
        
        //как отловить отмену .task() при исчезновении
        func addJob() {
            let job = RenderJob()
            jobs.append(job)
            let task = Task {
                
                let stream = renderEngine.startRender()
                for try await event in stream {
                    guard let jobIndex = jobs.firstIndex(where: { job.id == $0.id}) else { break }
                    switch event {
                    case .progress(let progress):
                        jobs[jobIndex].progress = progress
                    case .complete(let image):
                        jobs[jobIndex].image = image
                    case .error(let error):
                        self.error = error
                    }
                }
            }
            idToTaskMap[job.id] = task
        }
        
        func cancelJob(jobID: UUID) {
            idToTaskMap[jobID]?.cancel()
        }
        
        func  remove(indexes: IndexSet) {
            for i in indexes {
                let id = jobs[i].id
                cancelJob(jobID: id)
            }
            jobs.remove(atOffsets: indexes)
        }
    }
}
