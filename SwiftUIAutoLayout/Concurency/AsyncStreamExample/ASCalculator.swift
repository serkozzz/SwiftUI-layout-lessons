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
        
        func factorial(_ n: Int) -> AsyncThrowingStream<CalculationEvent, Error> {
            AsyncThrowingStream { continuation in
                guard n >= 0 else {
                    continuation.finish(throwing: ServerAPIError.unknown)
                    return
                }
                let _ = Task { @concurrent in
                    do {
                        var accumulator = 1
                        for i in 2...n {
                            if i.isMultiple(of: 10000) {
                                try Task.checkCancellation()
                                continuation.yield(.progress(Double(i) / Double(n)))
                            }
                            accumulator &+= i
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
}
