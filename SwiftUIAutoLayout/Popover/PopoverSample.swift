//
//  ContentView.swift
//  sandbox
//
//  Created by Sergey Kozlov on 02.09.2025.
//

import SwiftUI



struct PopoverSample: View {
    @State private var isPresented = false
    @State private var text = "X X X"
    @State private var size: CGSize = .zero
    
    var body: some View {
        VStack {
            Button("Popover") {
                isPresented = true
            }
            .textFittingPopover(text: text,
                                isPresented: $isPresented,
                                backgroundColor: .green,
                                width: nil)
        }
        .task {
            while true {
                try? await Task.sleep(for: .seconds(2))
                text = Array(repeating: "X", count: Int.random(in: 0..<50)).joined(separator: " ")
            }
        }
    }
}

#Preview {
    PopoverSample()
}
