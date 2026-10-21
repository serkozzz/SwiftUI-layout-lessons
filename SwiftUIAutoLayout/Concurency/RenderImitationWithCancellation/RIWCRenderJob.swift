//
//  RenderJob.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 21.10.2026.
//
import SwiftUI

extension RenderImitationWithCancellation {
    struct RenderJob: Identifiable {
        var id = UUID()
        var image: UIImage?
        var progress: Double = 0
    }
}
