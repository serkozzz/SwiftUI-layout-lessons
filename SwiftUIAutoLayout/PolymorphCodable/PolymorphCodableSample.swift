//
//  PolymorphCodableSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 26.10.2025.
//


import SwiftUI



struct PolymorphCodableSample: View {
    
    @State var number = 10
    @State var tree = PolymorphCodableSample.createTree()
    var body: some View {
        Text("Hello")
        Button("make json") {
            let data = try! PolymorphCodableTreeSerializer().encodeTree(tree)
            let jsonString = String(data: data, encoding: .utf8)!
            print(jsonString)
        }
    }
    
    
    static func createTree() -> PCNode {
        let text = PCViewNode(type: "Text")
        let vStack = PCViewNode(type: "VStack")
        vStack.children.append(text)
        
        let varNode = PCCVariableNode(name: "varNode", initCode: "print(\"Hello)\")")
        let root = PCNode()
        root.children.append(vStack)
        root.children.append(varNode)
        return root
    }
}

#Preview {
    PolymorphCodableSample()
}

