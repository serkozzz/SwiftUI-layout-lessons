//
//  CustomAnimation.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 25.08.2025.
//

import SwiftUI

struct Shake: AnimatableModifier {
    var times: CGFloat = 0
    let amplitude: CGFloat = 10
    nonisolated var animatableData: CGFloat {
        get { times }
        set { times = newValue
        print(newValue)}
    }
    func body(content: Content) -> some View {
        return content.offset(x: sin(times * .pi * 2) * amplitude)
    }
}
extension View {
    func shake(times: Int) -> some View {
        return modifier(Shake(times: CGFloat(times)))
    }
}

struct AnimatableModifierSample: View {
    @State private var taps: Int = 0
    var body: some View {
        Button("Hello") {
            withAnimation(.linear(duration: 0.5)) {
                self.taps += 1
            }
        }
        .shake(times: taps * 3)
    }
}



#Preview {
    AnimatableModifierSample()
}



