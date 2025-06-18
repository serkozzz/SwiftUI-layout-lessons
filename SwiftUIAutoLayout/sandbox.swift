//
//  sandbox.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 14.06.2025.
//

import SwiftUI



struct sandbox: View {
    
    @State var width: CGFloat? = 80
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: width)
            .padding(10)
            .background(GeometryReader { proxy in
                Color.clear
                    .onChange(of: proxy.size.width) {
                        self.width = width

                    }
            })
    }
}

#Preview {
    sandbox()
}
