//
//  SimpleMacroSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 14.11.2025.
//

import SwiftUI
import MyMacroPackage


@PrintMethods
class Test {
    var a = 100
    func testMethod() -> Int { return 10 }
    func aaaa() {}
}


struct SimpleMacroSample: View {
    
    var number1 = Int(100)
    var test = Test()
    
    var body: some View {
        test.printMethods()
        print(#stringify(number1))
        return Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SimpleMacroSample()
}
