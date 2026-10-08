//
//  RenderManager.swift
//  RenderImitation
//
//  Created by Sergey Kozlov on 05.10.2026.
//

import SwiftUI
import Combine

extension RenderImitation {
    
    @MainActor
    class RenderEngine {
        
        enum Event {
            case progress(Double)
            case complete(UIImage)
            case error(RenderError)
        }
        
        @concurrent
        func nextIteration(for job: RenderJob) async throws {
            try await Task.sleep(for: .seconds(0.1))
        }
        
        func render(_ job: RenderJob) -> AsyncThrowingStream<Event, Error> {
            AsyncThrowingStream<Event, Error>() { continuation in
                let task = Task { @concurrent in
                    do {
                        for i in 0...100 {
                            
                            try await nextIteration(for: job)
                            continuation.yield(.progress(Double(i) / 100.0))
                            try Task.checkCancellation()
                        }
                        continuation.yield(.complete(UIImage(systemName: "arrow.down")!))
                        continuation.finish()
                    }
                    catch {
                        continuation.finish(throwing: error) //обязательно нужно, потому что иначе исключение не перейдет границу task наверх
                    }
                }
                
                continuation.onTermination = { @Sendable _ in
                    task.cancel()
                }
            }
        }
    }
}
