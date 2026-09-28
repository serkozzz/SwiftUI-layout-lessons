//
//  JobData.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 28.09.2026.
//



import SwiftUI

enum HardCalculationsExample {
    
    //можете пробовать class, struct(Sendable), actor
    struct JobData {
        
        var startNumber: Int = 0
    }
    
    //можете пробовать class, struct
    struct Calculator {
        @concurrent
        func hardJob(_ jobData: JobData) async throws -> Int {
            print( jobData.startNumber)
//            await MainActor.run() {
//                jobData.startNumber += 1
//            }
            var result = 0
            for i in 0...100_000_000 {
                if i.isMultiple(of: 100000) {
                    try Task.checkCancellation()
                }
                result &+= i
            }
            return result
        }
    }
    
    
    struct ContentView: View {
        var jobData = JobData()
        
        var calculator = Calculator()
        var body: some View {
            VStack {
                
            }
            .task() {
                do {
                    let result = try await calculator.hardJob(jobData)
                    print(result)
                }
                catch is CancellationError {
                }
                catch {}
            }
            .task {
                //jobData.startNumber = 100
            }
        }
    }
}
