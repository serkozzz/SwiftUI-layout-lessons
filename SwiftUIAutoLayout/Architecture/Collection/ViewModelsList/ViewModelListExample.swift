//
//  ViewModelExample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 31.07.2025.
//

import SwiftUI
import Combine

enum ViewModelsListExample {
    struct ContentView: View {
        
        private var group: Group
        
        @StateObject private var groupViewModel: GroupViewModel
        
        init() {
            group = Group(items: [
                Item(id: 1, name: "item1"),
                Item(id: 2, name: "item2"),
                Item(id: 3, name: "item3"),
                Item(id: 4, name: "item4"),
                Item(id: 5, name: "item5")])
            let groupVM = GroupViewModel(group: group)
           _groupViewModel = StateObject(wrappedValue: groupVM)
        }
        
        var body: some View {
            VStack {
                Button("add") { groupViewModel.addItem() }
                Button("change 1st item") { groupViewModel.changeFirstItem() }
                GroupView(groupViewModel: groupViewModel)
            }
        }
    }
}



