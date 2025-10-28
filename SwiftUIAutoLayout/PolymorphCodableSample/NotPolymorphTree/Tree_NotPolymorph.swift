//
//  Tree_PCSProtocol.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 27.10.2025.
//

import Foundation

enum NotPolymorphCodableTreeSample {
    
    
    class Node: Codable {
        var id = UUID()
        var children: [Node] = []
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
}
