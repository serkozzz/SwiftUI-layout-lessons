//
//  GroupViewModel.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 25.09.2026.
//

import SwiftUI
import Combine

extension ModelsListExample  {
    class GroupViewModel : ObservableObject {
        @Published var items: [Item] = []
        private var group: Group
        private var cancellables: Set<AnyCancellable> = []
        
        init(group: Group) {
            self.group = group
            items = group.items
            group.itemsChangedPublisher.sink {[weak self] items in
                guard let self else { return }
                self.items = group.items
            }.store(in: &cancellables)
        }
        
        func addItem() {
            let id = group.items.count + 1
            let item = Item(id: id , name: "item\(id)")
            group.addItem(item)
        }
        
        func changeFirstItem() {
            group.setItemName(item: group.items[0], newName: "changed")
        }
    }
}
