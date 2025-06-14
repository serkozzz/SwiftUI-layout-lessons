//
//  Untitled.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 13.06.2025.
//
import SwiftUI

struct CircleCenterKey: PreferenceKey {
    static let defaultValue: Anchor<CGPoint>? = nil
    
    static func reduce(value: inout Anchor<CGPoint>?, nextValue: () -> Anchor<CGPoint>?) {
        value = value ?? nextValue()
    }
}


struct AnchorSimpleExample: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .anchorPreference(
                                key: CircleCenterKey.self,
                                value: .center
                            ) { anchor in anchor }
                    }
                )
        }
        // Теперь родитель использует это значение
        .overlayPreferenceValue(CircleCenterKey.self) { anchor in
            GeometryReader { proxy in
                if let anchor = anchor {
                    let point = proxy[anchor]  // вот тут получаем абсолютную точку
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                        .position(x: point.x, y: point.y - 30)
                }
            }
        }
    }
}

#Preview {
    AnchorSimpleExample()
}
