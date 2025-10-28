//
//  Sample_PCSProtocol.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 27.10.2025.
//

import SwiftUI

extension NotPolymorphCodableTreeSample {
    struct ContentView: View {
        
        @State var number = 10
        @State var tree = ContentView.createTree()
        var body: some View {
            Text("Hello")
            Button("make json") {
                
                let data = try! JSONEncoder().encode(tree)
                
                let restoredTree = try! JSONDecoder().decode(NotPolymorphCodableTreeSample.Node.self, from: data)
                
                let encoder = JSONEncoder()
                encoder.outputFormatting = [.prettyPrinted]
                let newData = try! encoder.encode(restoredTree)
                
                
                let jsonString = String(data: newData, encoding: .utf8)!
                print(jsonString)
            }
        }
        
        
        static func createTree() -> Node {
            let car = Node(name: "car")
            let wheel1 = Node(name: "wheel1")
            let wheel2 = Node(name: "wheel2")
            car.children.append(wheel1)
            car.children.append(wheel2)
            
            let plane = Node(name: "plane")
            let wing1 = Node(name: "wing1")
            let wing2 = Node(name: "wing2")
            plane.children.append(wing1)
            plane.children.append(wing2)
            
            let root = Node(name: "root")
            root.children.append(car)
            root.children.append(plane)
            return root
        }
    }

}
