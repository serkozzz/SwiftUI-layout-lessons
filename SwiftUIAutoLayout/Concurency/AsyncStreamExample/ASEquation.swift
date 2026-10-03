//
//  FacEquation.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 29.09.2026.
//


extension AsyncStreamExample {
    
    struct Equation: Identifiable {
        var base: Int
        var result: Int
        
        func text() -> String {
            "\(base)! = \(result)"
        }
        
        var id: Int {
            base
        }
    }
}
