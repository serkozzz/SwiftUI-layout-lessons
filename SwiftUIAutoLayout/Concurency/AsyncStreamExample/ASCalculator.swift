//
//  FacCalculator.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 29.09.2026.
//

import SwiftUI

extension FactorialExample {
    
    class Calculator {
        
        @concurrent
        func factorial(_ n: Int) async throws -> Equation {
            guard n >= 0 else { throw ServerAPIError.unknown }
            do {
                var accumulator = 1
                for i in 2...n {
                    if i.isMultiple(of: 100) {
                        try Task.checkCancellation()
                    }
                    accumulator &+= i
                }
                return Equation(base: n, result: accumulator)
            }
            catch let error as CancellationError {
                print("cancellation in @concurrent")
                throw error
            }
        }
    }
    
    
}
