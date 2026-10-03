//
//  FacCalculator.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 29.09.2026.
//

import SwiftUI

extension AsyncStreamExample {
    
    enum CalculationEvent {
        case progress(Double)
        case complete(Equation)
    }
    
    class Calculator {
        
@concurrent
func factorial(_ n: Int) async throws -> AsyncThrowingStream<CalculationEvent, Error> {
    AsyncThrowingStream { continuation in
        guard n >= 0 else {
            continuation.finish(throwing: ServerAPIError.unknown)
            return
        }
        do {
            var accumulator = 1
            for i in 2...n {
                if i.isMultiple(of: 100) {
                    try Task.checkCancellation()
                }
                accumulator &+= i
                continuation.yield(.progress(Double(i) / Double(n)))
            }
            continuation.yield(.complete(Equation(base: n, result: accumulator)))
            continuation.finish()
        }
        catch is CancellationError {
            print("cancellation in @concurrent")
            continuation.finish(throwing: ServerAPIError.cancellation)
        }
        catch {
            continuation.finish(throwing: ServerAPIError.unknown)
        }
    }
}
    }
    
    
}
