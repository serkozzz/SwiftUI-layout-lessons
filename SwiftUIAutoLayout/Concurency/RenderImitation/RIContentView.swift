//
//  RIContentView.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 05.10.2026.
//
import SwiftUI

extension RenderImitation {
    struct ContentView: View {
        private let renderEngine = RenderEngine()
        var body: some View {
            RenderManagerView(renderEngine: renderEngine)
        }
    }
}
