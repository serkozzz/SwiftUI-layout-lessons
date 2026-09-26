//
//  ItemViewModel.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 25.09.2026.
//

import SwiftUI
import Combine

extension ViewModelsListExample {
    class ItemViewModel: ObservableObject, Identifiable {
        @Published var title: String
        private(set) var id: Int
        
        init(item: Item) {
            self.title = item.name
            self.id = item.id
            item.namePublisher.removeDuplicates().assign(to: &$title)
        }
        
        func changeTitle() {
            
        }
    }
    
}
