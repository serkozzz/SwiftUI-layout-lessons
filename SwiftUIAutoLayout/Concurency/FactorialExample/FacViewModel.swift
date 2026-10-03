//
//  ViewModel.swift
//  sandbox
//
//  Created by Sergey Kozlov on 28.09.2026.
//

import SwiftUI
import Combine

extension FactorialExample {
    
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
                    for try await result in group {
                        equations.append(result)
                    }
                    self.equations = equations
                }
            }
        }
        
        func calculateWithUnstructedConcurrensy() async throws {
            for base in bases {
                let task = Task {
                    let result = try await Calculator().factorial(base)
                    self.equations.append(result)
                }
                self.tasks.append(task)
            }
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

