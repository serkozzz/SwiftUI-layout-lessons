//
//  sandbox.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 29.06.2025.
//

import SwiftUI
import Combine


struct sandbox: View {
    
    @State var number = 10
    @State var a = 0
    var body: some View {
        var s = myFunc()
        Text(s)
        Text(String(number))
        Button("tap \(a)") {
            a = a + 1
        }
    }
    
    func myFunc() -> String {
        number += 1
        print(number)
        return "a"
        
    }
}

#Preview {
    sandbox()
}

