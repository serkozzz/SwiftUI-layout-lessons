//
//  RenderManager.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 20.10.2026.
//

import SwiftUI
import Combine

extension RenderImitationWithCancellation {
    
    enum RenderManagerEvent {
        case progress(Double)
        case complete(UIImage)
        case error(Error)
    }
    
    @MainActor
    class RenderEngine {
        @concurrent
        private func render() async throws {
            try await Task.sleep(for: .seconds(0.3))
        }
        
        func startRender() -> AsyncThrowingStream<RenderManagerEvent, Error> {
            AsyncThrowingStream<RenderManagerEvent, Error>() { continuation in
                let task = Task { @concurrent in
                    do {
                        for i in 0...100 {
                            try await render()
                            continuation.yield(RenderManagerEvent.progress(Double(i) / 100.0 ))
                        }
                        continuation.yield(.complete(UIImage(systemName: "arrow.down")!))
                        continuation.finish()
                    }
                    catch  {
                        continuation.finish(throwing: error)
                    }
                }
                continuation.onTermination = { _ in
                    task.cancel()
                }
            }
        }
    }
}
