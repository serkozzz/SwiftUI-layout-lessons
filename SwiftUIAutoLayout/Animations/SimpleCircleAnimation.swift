//
//  SimpleCircleAnimation.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 26.08.2025.
//



import SwiftUI
import Combine

struct LoadingIndicator: View {
    @State var appeared = false
    let animation = Animation
        .linear(duration: 2)
        .repeatForever(autoreverses: false)
    
    var body: some View {
        Circle()
            .fill(Color.accentColor)
            .frame(width: 5, height: 5)
            .zIndex(100)
            .offset(y: -20)
            .rotationEffect(appeared ? Angle.degrees(360) : .zero)
            .onAppear {
                withAnimation(animation) {
                    self.appeared = true
                }
            }
                
            .background {
                Rectangle().stroke(.red)
            }
        
        Text("Hello")
            .background(.yellow)
    }
}

struct SimpleCircleAnimation : View {
    var body: some View {
        LoadingIndicator()
    }
}

#Preview {
    SimpleCircleAnimation()
}

