//
//  PolymorphCodableTreeSerializer.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 26.10.2025.
//

import Foundation

class PolymorphCodableTreeSerializer {
    private let encoder = JSONEncoder()
    
    func encodeTree(_ root: PCNode) throws -> Data {
        let dict = try encodeNode(root)
        return try JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted])
    }
    
    func encodeNode(_ node: PCNode) throws -> [String: Any] {
        let childrenCopy = node.children
        node.children = []
        
        let bodyData: Data
        bodyData = try encoder.encode(node)
        
        guard var dict = try JSONSerialization.jsonObject(with: bodyData) as? [String: Any] else {
            throw NSError(domain: "EncoderError", code: 1)
        }
        dict["kind"] = nodeKind(node).rawValue
        node.children = childrenCopy
        
        if !node.children.isEmpty {
            dict["children"] = try node.children.map { try encodeNode($0) }
        }
        
        if !JSONSerialization.isValidJSONObject(dict) {
            print("❌ Invalid JSON object:", dict)
            throw NSError(domain: "JSONSerialization", code: 0, userInfo: nil)
        }
        return dict
    }
    
    func nodeKind(_ node: PCNode) -> NodeKind {
        if (node is PCViewNode) { return .view }
        if (node is PCCVariableNode) { return .variable }
        return .base
    }
}
