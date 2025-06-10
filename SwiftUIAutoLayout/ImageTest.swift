//
//  ImageTest.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 09.06.2025.
//

import SwiftUI

struct ImageTest: View {
    @State private var width: CGFloat = 100
    @State private var height: CGFloat = 100
    let image = Image("beatImage")
    var body: some View {
        
        VStack {
            image
                //.resizable(resizingMode: .stretch)
                //.aspectRatio(contentMode: .fit)
                .border(.red, width: 3)
                .frame(width: width, height: height)
                .border(Color.blue, width: 3)
                .clipped()
            Slider(value: $width, in: 0...500)
            Slider(value: $height, in: 0...500)
            
            Text("""
                 Hello 
                 """)
               // .frame(width: 100, height: 100 )
                .border(.blue, width: 3)
            Rectangle()
                .fill(.gray)
                .cornerRadius(40)
                .padding(30)
        }
    }
}

#Preview {
    ImageTest()
}
