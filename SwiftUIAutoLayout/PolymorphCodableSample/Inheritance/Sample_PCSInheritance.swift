//
//  PolymorphCodableSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 26.10.2025.
//


import SwiftUI


//пример с encode/decode дерева + иерархия классов. То есть дерево, где каждый нод может быть подклассом Node.
//используется встроенная система: required init(from decoder: Decoder) + func encode(to encoder: Encoder)
//то есть node кодируется одной строчкой: bodyData = try JSONEncoder.encode(node)
//но чтобы это было возможно приходится вручную в каждом подклассе реализовывать init(from decoder: Decoder) + func encode(to encoder: Encoder). Вручную кладем каждое св-во.
//Чтобы понимать какой нод мы сейчас декодируем, при кодировании мы записываем доп поле "kind". Этим занимается Serializer, проходит по дереву и пишет kind и body класса.
//
//

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
