//
//  sandbox.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 14.06.2025.
//

import SwiftUI


private struct WidthKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}


struct CircleWithTextWithoutPref: View {
    
    @State private var width: CGFloat? 
    
    @State var text: String = "Hello"
    var body: some View {
        
        Text(text)
            .foregroundColor(.white)
            .onGeometryChange(for: CGFloat.self, of: { proxy in proxy.size.width }) { newWidth in
                 width = newWidth
             }
            .frame(width: self.width, height: width)
            .padding(10)
            .border(.black)
            .background(Circle().fill(Color.blue))
        Button ("add symbol"){
            width = nil
            text = text + "1"
        }
    }
    
    
    private func updateW(value: CGFloat) {
        width = value
        print("width = \(value)")
    }
}


#Preview {
    CircleWithTextWithoutPref()
}
