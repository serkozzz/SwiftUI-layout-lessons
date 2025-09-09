//
//  AnimatableSample.swift
//  sandbox
//
//  Created by Sergey Kozlov on 06.09.2025.
//

import SwiftUI

//если вы делаете View: Animatable то будет интерполироваться само её свойство animatableData. Если бы это была не вью а просто произвольная тектсура, то само свойство бы не интерполировалось

struct AnimatingNumberText: View, Animatable {
    
    var value: CGFloat //instead you can delete this prop and use stored animatableData from outside
    
    nonisolated var animatableData: CGFloat {
        get { value }
        set { value = newValue } // SwiftUI будет задавать промежуточные значения на каждом кадре
    }
    var body: some View {
        Text("Velocity: \(value, specifier: "%.2f")")
    }
}

struct AnimatableViewSample: View {
    @State private var value: CGFloat = 0

    var body: some View {
        VStack(spacing: 16) {
            Circle()
                .fill(.blue)
                .frame(width: value, height: value)   // это анимируется через CA

            AnimatingNumberText(value: value)        // а вот это — через Animatable (покадрово)

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
