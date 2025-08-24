//
//  EndlessRotationSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 25.08.2025.
//

import SwiftUI


struct EndlessRotationSample: View {
    @State var isAnimating = false
    
    var body: some View {
        Button("Tap me") {
        }
        .rotationEffect(isAnimating ? Angle.degrees(360) : .zero)
        .animation(
            .linear(duration: 2)
            .repeatForever(autoreverses: false), value: isAnimating)
        .onAppear() {
            isAnimating = true
        }
    }
}



#Preview {
    EndlessRotationSample()
}

