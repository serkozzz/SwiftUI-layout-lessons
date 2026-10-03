//
//  ViewModel.swift
//  sandbox
//
//  Created by Sergey Kozlov on 28.09.2026.
//

import SwiftUI
import Combine

extension AsyncStreamExample {
    
    enum ConcurencyType {
        case groupTask
        case unstructed
    }
    
    @MainActor
    class ViewModel: ObservableObject {
        var bases = [Int](1000000...1000030)
        @Published var equations: [Equation] = []
        @Published var error: ServerAPIError?
        @Published var emulateException = false
         
        private var groupTask: Task<Void, Error>?
        private var tasks: [Task<Void, Error>] = []
        
        func calculateAll(_ concurencyType: ConcurencyType) async  {
            
            cancellAll()
            bases[0] = emulateException ? -1 : 1000
            equations = []
            
            do {
                print("start")
                switch concurencyType {
                case .groupTask:
                    try await calculateUsingTaskGroup()
                case .unstructed:
                    try await calculateWithUnstructedConcurrensy()
                }                
            }
            catch is CancellationError {
                print("cancellationError in parent")
                self.error = ServerAPIError.cancellation
            } catch {
                self.error = ServerAPIError.unknown
            }
            
        }
        
        func calculateUsingTaskGroup() async throws  {
            self.groupTask = Task { //сохраняем только для отмены
                try await withThrowingTaskGroup { group in
                    for base in bases {
                        group.addTask {
                            try await Calculator().factorial(base)
                        }
                    }
                    var equations: [Equation] = []
                    for try await stream in group {
                        let equation = try await handleStream(stream)
                        equations.append(equation)
                    }
                    self.equations = equations
                }
            }
        }
        
        func calculateWithUnstructedConcurrensy() async throws {
            for base in bases {
                let task = Task {
                    let stream = try await Calculator().factorial(base)
                    let equation = try await handleStream(stream)
                    self.equations.append(equation)
                }
                self.tasks.append(task)
            }
        }
        
        private func handleStream(_ stream: AsyncThrowingStream<CalculationEvent, Error>) async throws -> Equation {
            do {
                for try await event in stream {
                    switch event {
                    case .progress(let progress):
                        print(progress)
                        
                    case .complete(let equation):
                        return equation
                    }
                }
            }
            catch {
                throw error
            }
            throw ServerAPIError.unknown
        }
        
        func cancellAll() {
            if let groupTask {
                groupTask.cancel()
                self.groupTask = nil
            }
            tasks.forEach{ $0.cancel()}
            tasks = []
        }
    }
    
    struct Photo: Identifiable {
        var id: UUID = UUID()
        var image: UIImage
    }
}

