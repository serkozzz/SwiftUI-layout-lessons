//
//  ItemView.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 26.09.2026.
//

import SwiftUI
import Combine

extension ViewModelsListExample {
    
    struct ItemView: View {
        
        @ObservedObject var itemVM: ItemViewModel
    
        var body: some View {
            HStack {
                Text(itemVM.title)
            }
        }
    }
}
