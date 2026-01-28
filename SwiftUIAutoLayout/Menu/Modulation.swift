//
//  Modulation.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 17.01.2026.
//

enum MenuSample {
    enum Modulation {
        enum Source: String, CaseIterable, Identifiable {
            case lfo1, lfo2, env1, env2
            var id: String { rawValue }
        }
    }
}
