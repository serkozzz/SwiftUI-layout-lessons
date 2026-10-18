//
//  ColorDTO.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 17.10.2026.
//

struct ColorDTO: Decodable, Identifiable {
    var name: String
    var id: Int
    var icon: String
}
