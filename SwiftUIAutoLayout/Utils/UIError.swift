//
//  UIError.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 18.04.2026.
//


import Foundation

struct UIError: Error, Identifiable {
    var id = UUID()
    let message: String
}
