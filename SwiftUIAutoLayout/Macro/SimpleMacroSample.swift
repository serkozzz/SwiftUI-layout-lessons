//
//  SimpleMacroSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 14.11.2025.
//

import SwiftUI
import MyMacroPackage


struct SimpleMacroSample: View {
    
    //@TEPreviewable
    var number = 100
    
    var body: some View {
        print(#stringify(number))
        return Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SimpleMacroSample()
}
