//
//  GroupViewModel.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 25.09.2026.
//

import SwiftUI
import Combine

extension ViewModelsListExample  {
    class GroupViewModel : ObservableObject {
        @Published var itemVMs: [ItemViewModel] = []
        private var group: Group
        private var cancellables: Set<AnyCancellable> = []
        
        init(group: Group) {
            self.group = group
            itemVMs = group.items.map { ItemViewModel(item: $0)}
            group.itemsChangedPublisher.sink {[weak self] items in
                guard let self else { return }
                self.itemVMs = items.map { ItemViewModel(item: $0)}
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
