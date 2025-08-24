//
//  ContentView.swift
//  sandbox
//
//  Created by Sergey Kozlov on 15.07.2025.
//

import SwiftUI
import Combine


struct SimpleOpacityAnimation: View {
    @State var showCopy = false
    
    var body: some View {
        Button("Tap me") {
            showCopy.toggle()
        }
        .overlay {
            Text("Copied")
                .foregroundColor(Color(.systemBackground))
                .font(.system(size: 12))
                .frame(width: 60, height: 28)
                .background(.primary.opacity(0.8))
                .cornerRadius(6)
                .offset(x: 0, y: -38)
                .opacity(showCopy ? 1 : 0)
                .animation(.easeInOut(duration: 0.2), value: showCopy)
        }
    }
}



#Preview {
    SimpleOpacityAnimation()
}

