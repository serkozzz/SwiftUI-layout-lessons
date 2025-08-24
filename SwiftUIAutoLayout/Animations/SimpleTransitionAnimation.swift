//
//  ContentView.swift
//  sandbox
//
//  Created by Sergey Kozlov on 15.07.2025.
//

import SwiftUI
import Combine


struct SimpleTransitionAnimation: View {
    @State var showCopy = false
    
    var body: some View {
        Button("Tap me") {
            withAnimation(.easeInOut(duration: 1)) {
                showCopy = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation(.easeInOut(duration: 0.35)) {
                    showCopy = false
                }
            }

        }
        .overlay {
            if (showCopy) {
                Text("Copied")
                    .foregroundColor(Color(.systemBackground))
                    .font(.system(size: 12))
                    .frame(width: 60, height: 28)
                    .background(.primary.opacity(0.8))
                    .cornerRadius(6)
                    .offset(x: 0, y: -38)
                    .transition(.opacity.combined(with: .slide))
            }
        }
        //.animation(.default, value: showCopy) // либо так вместо withAnimation
    }
}



#Preview {
    SimpleTransitionAnimation()
}

