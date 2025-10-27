//
//  Sample_PCSProtocol.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 27.10.2025.
//

import SwiftUI

enum PolymorphCodableSampleEnum {
    struct ContentView: View {
        
        @State var number = 10
        @State var tree = ContentView.createTree()
        var body: some View {
            VStack {
                Text("Hello")
                Button("make json") {
                    let data = try! JSONEncoder().encode(tree)
                    let restoredTree = try! JSONDecoder().decode(Node.self, from: data)
                    let newData = try! JSONEncoder().encode(restoredTree)
                    
                    let jsonString = String(data: newData, encoding: .utf8)!
                    print(jsonString)
                }
            }
        }
        
        static func createTree() -> Node {
            let text = Node.view(type: "Text", children: [])
            let vStack = Node.view(type: "VStack", children: [text])
            let varNode = Node.variable(name: "varNode", initCode: "print(\"Hello)\")", children: [])
            let root = Node.base(children: [vStack, varNode])
            return root
        }
    }
}

#Preview {
    PolymorphCodableSampleEnum.ContentView()
}
