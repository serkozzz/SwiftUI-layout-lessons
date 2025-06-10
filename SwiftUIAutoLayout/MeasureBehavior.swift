//
//  Test.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 09.06.2025.
//

import SwiftUI

struct MeasureBehavior<Content: View>: View {
    @State private var width: CGFloat = 100
    @State private var height: CGFloat = 100
    var content: Content
    var body: some View {
        VStack {
            content
                .border(Color.gray)
                .frame(width: width, height: height, alignment: .center)
                .border(Color.black)
            Slider(value: $width, in: 0...500)
            Slider(value: $height, in: 0...200)
        }
    }
}

#Preview {
    MeasureBehavior(content:
                        HStack {
            Text("Hello, World")
            Text("It's me!")
            .layoutPriority(1)
        }
    )
}

