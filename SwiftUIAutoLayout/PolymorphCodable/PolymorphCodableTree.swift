//
//  PolymorphCodableTree.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 26.10.2025.
//


import SwiftUI
import Combine

enum NodeKind : String, Codable {
    case base
    case variable
    case view
}

class PCNode: Codable {
    var id = UUID()
    var children: [PCNode] = []
}

class PCCVariableNode: PCNode {
    
    var name: String
    var initCode: String
    init(name: String, initCode: String) {
        self.name = name
        self.initCode = initCode
        super.init()
    }
    
    enum CodingKeys: CodingKey {
        case name, initCode
    }
    required init(from decoder: Decoder) throws {

        let c = try decoder.container(keyedBy: CodingKeys.self)
        name = try c.decode(String.self, forKey: .name)
        initCode = try c.decode(String.self, forKey: .initCode)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(name, forKey: .name)
        try c.encode(initCode, forKey: .initCode)
    }
}

class PCViewNode: PCNode {
    var type: String
    init(type: String) {
        self.type = type
        super.init()
    }
    
    enum CodingKeys: CodingKey {
        case type
    }
    
    required init(from decoder: Decoder) throws {

        let c = try decoder.container(keyedBy: CodingKeys.self)
        type = try c.decode(String.self, forKey: .type)
        try super.init(from: decoder)
        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(type, forKey: .type)
    }
}
