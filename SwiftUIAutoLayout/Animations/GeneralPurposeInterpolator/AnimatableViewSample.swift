//
//  AnimatableSample.swift
//  sandbox
//
//  Created by Sergey Kozlov on 06.09.2025.
//

import SwiftUI

//если вы делаете View: Animatable то будет интерполироваться само её свойство animatableData. Если бы это была не вью а просто произвольная тектсура, то само свойство бы не интерполировалось

struct AnimatingNumberText: View, Animatable {
    

    var animatableData: CGFloat

    var body: some View {
        Text("Velocity: \(animatableData, specifier: "%.2f")")
    }
}

struct AnimatableViewSample: View {
    @State private var value: CGFloat = 0

    var body: some View {
        VStack(spacing: 16) {
            Circle()
                .fill(.blue)
                .frame(width: value, height: value)   // это анимируется через CA

            AnimatingNumberText(animatableData: value)        // а вот это — через Animatable (покадрово)

            Button("Start Animation") {
                withAnimation(.easeInOut(duration: 2)) {
                    value = 100
                } completion: {
                    withAnimation(.easeInOut(duration: 2)) {
                        value = 0
                    }
                }
            }
        }
    }
}

#Preview {
    AnimatableViewSample()
}

