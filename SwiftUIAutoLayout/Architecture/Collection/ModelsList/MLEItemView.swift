//
//  ItemView.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 26.09.2026.
//

import SwiftUI
import Combine

extension ModelsListExample {
    
    struct ItemView: View {
        
        var item: Item
    
        var body: some View {
            HStack {
                Text(item.name)
            }
        }
    }
}
