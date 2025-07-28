//
//  sandbox.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 29.06.2025.
//

import SwiftUI
import Combine


struct sandbox: View {
    
    var body: some View {
        NavigationStack {
            List {
                ZStack {
                    Rectangle()
                        .fill(.yellow)
                        .frame(width: 100, height: 100)
                    NavigationLink(value: 10) {
                        EmptyView()
                    }
                }
                ZStack {
                    Text("Hello")
                    NavigationLink(value: 10) {
                        //EmptyView()
                    }
                   // .opacity(0)
                }
            }
            .navigationDestination(for: Int.self) { number in
                Text("Subview")
            }
        }
    }
}

#Preview {
    sandbox()
}

