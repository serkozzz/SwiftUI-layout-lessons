//
//  ModulationSourceMenu.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 17.01.2026.
//

import SwiftUI

extension MenuSample {
    struct ModulationSourceMenu: View {
        
        var onSelect: (Modulation.Source) -> Void
        var items: [Modulation.Source]
        
        var body: some View {
            List {
                ForEach(items) { item in
                    Button {
                        onSelect(item)
                    } label: {
                        Text(item.rawValue)
                    }
                }
            }
        }
    }
}
