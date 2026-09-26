//
//  ItemGroup.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 25.09.2026.
//

import SwiftUI
import Combine

extension ModelsListExample {
    
    class Group {
        private(set) var items: [Item] {
            didSet {
                itemsChangedSubject.send(items)
            }
        }
        
        private let itemsChangedSubject: CurrentValueSubject<[Item], Never>
        var itemsChangedPublisher: AnyPublisher<[Item], Never> { itemsChangedSubject.eraseToAnyPublisher() }
        
        init(items: [Item]) {
            self.items = items
            itemsChangedSubject = CurrentValueSubject(self.items)
        }
        
        func addItem(_ item: Item) {
            items.append(item)
        }
        
        func setItemName(item: Item, newName: String) {
            guard let index = items.firstIndex(where: { $0 == item}) else { return }
            items[index].name = newName
        }
    }
}
