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
                //.frame(width: width, height: height, alignment: .center)
                .border(Color.black)
            
            Slider(value: $width, in: 0...500)
            Slider(value: $height, in: 0...200)
        }
    }
}

#Preview {
    MeasureBehavior(content:
            ZStack {
                Text("sdsdasdasdasdsa")
                    .position(CGPoint(x:0, y: 0))
            }
        .frame(width: 100, height: 100)
        .background {
            Color.red
        }
    )
}

