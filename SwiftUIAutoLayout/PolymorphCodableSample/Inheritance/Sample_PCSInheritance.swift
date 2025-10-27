//
//  PolymorphCodableSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 26.10.2025.
//


import SwiftUI

enum PolymorphCodableSampleInheritance {
    
    struct ContentView: View {
        
        @State var number = 10
        @State var tree = ContentView.createTree()
        var body: some View {
            Text("Hello")
            Button("make json") {
                let data = try! TreeSerializer().encodeTree(tree)
                
                let restoredTree = try! TreeSerializer().decodeTree(data: data)
                
                let newData = try! TreeSerializer().encodeTree(restoredTree)
                
                let jsonString = String(data: newData, encoding: .utf8)!
                print(jsonString)
            }
        }
        
        
        static func createTree() -> Node {
            let text = ViewNode(type: "Text")
            let vStack = ViewNode(type: "VStack")
            vStack.children.append(text)
            
            let varNode = VariableNode(name: "varNode", initCode: "print(\"Hello)\")")
            let root = Node()
            root.children.append(vStack)
            root.children.append(varNode)
            return root
        }
    }

    
}

#Preview {
    PolymorphCodableSampleInheritance.ContentView()
}
