//
//  sandbox.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 10.06.2025.
//

import SwiftUI

struct WidthKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}


struct CircleWithText: View {
    @State private var width: CGFloat?
    
    var body: some View {
        
        Text("Hello, world")
            .foregroundColor(.white)
            .background(GeometryReader { proxy in
                Color.clear
                    .preference(key: WidthKey.self, value: proxy.size.width)
            })
            .onPreferenceChange(WidthKey.self) { width in
                DispatchQueue.main.async {
                    self.width = width
                }
            }
            .frame(width: self.width, height: width)
            .padding(10)
            .border(.black)
            .background(Circle().fill(Color.blue))
    }
}

private struct Cell: View {
    var body: some View {
        Rectangle()
            .frame(width: 50)
    }
}

#Preview {
    CircleWithText()
}
