//
//  SimpleMacroSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 14.11.2025.
//

import SwiftUI
import MyMacroPackage


class Test {
    @TEPreviewable var boundingBox = CGSize(width: 100, height: 100)
}

struct SimpleMacroSample: View {
    
    var number1 = Int(100)
    
    var body: some View {
        print(#stringify(number1))
        return Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SimpleMacroSample()
}
