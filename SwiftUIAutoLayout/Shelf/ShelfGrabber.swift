//
//  ShelfGrabber.swift
//  ShelfViewer
//
//  Created by Sergey Kozlov on 05.10.2026.
//

import SwiftUI
import Combine

struct ShelfGrabber: View {
    var isHighlighted: Bool
    private let idleColor = Color(UIColor.gray)
    private let highlightedColor = Color(UIColor.white)
    
    var body: some View {
        Capsule()
            .fill(isHighlighted ? highlightedColor : idleColor)
            .frame(width: 36, height: 5)
            .animation(.easeIn(duration: 0.2), value: isHighlighted)
    }
}
