//
//  RenderJob.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 22.10.2026.
//
import SwiftUI

extension RenderImitationGCD {
    struct RenderJob : Identifiable {
        let id = UUID()
        var image: UIImage?
        var progress: Double = 0
    }
}
