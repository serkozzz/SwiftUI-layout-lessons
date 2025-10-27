//
//  Tree_PCSProtocol.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 27.10.2025.
//

import Foundation

extension PolymorphCodableSampleEnum {
    
    enum Node: Codable, Equatable {
        case base(children: [Node])
        case variable(name: String, initCode: String, children: [Node])
        case view(type: String, children: [Node])
        
        // Внутренний дискриминатор для стабильного JSON
        private enum Kind: String, Codable { case base, variable, view }
        private enum CodingKeys: String, CodingKey { case kind, children, name, initCode, type }
        
        // MARK: - Encode
        func encode(to encoder: Encoder) throws {
            var c = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .base(let children):
                try c.encode(Kind.base, forKey: .kind)
                try c.encode(children, forKey: .children)
            case .variable(let name, let initCode, let children):
                try c.encode(Kind.variable, forKey: .kind)
                try c.encode(name, forKey: .name)
                try c.encode(initCode, forKey: .initCode)
                try c.encode(children, forKey: .children)
            case .view(let type, let children):
                try c.encode(Kind.view, forKey: .kind)
                try c.encode(type, forKey: .type)
                try c.encode(children, forKey: .children)
            }
        }
        
        // MARK: - Decode
        init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            let kind = try c.decode(Kind.self, forKey: .kind)
            switch kind {
            case .base:
                let children = try c.decodeIfPresent([Node].self, forKey: .children) ?? []
                self = .base(children: children)
            case .variable:
                let name = try c.decode(String.self, forKey: .name)
                let initCode = try c.decode(String.self, forKey: .initCode)
                let children = try c.decodeIfPresent([Node].self, forKey: .children) ?? []
                self = .variable(name: name, initCode: initCode, children: children)
            case .view:
                let type = try c.decode(String.self, forKey: .type)
                let children = try c.decodeIfPresent([Node].self, forKey: .children) ?? []
                self = .view(type: type, children: children)
            }
        }
        
        // MARK: - Удобный доступ к children
        var children: [Node] {
            get {
                switch self {
                case .base(let ch): return ch
                case .variable(_, _, let ch): return ch
                case .view(_, let ch): return ch
                }
            }
            set {
                switch self {
                case .base:
                    self = .base(children: newValue)
                case .variable(let name, let initCode, _):
                    self = .variable(name: name, initCode: initCode, children: newValue)
                case .view(let type, _):
                    self = .view(type: type, children: newValue)
                }
            }
        }
    }
}
