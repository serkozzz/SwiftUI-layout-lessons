//
//  ViewModelsListExample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 26.09.2026.
//

import SwiftUI
import Combine

extension ViewModelsListExample {
    
    struct GroupView: View {
        
        @ObservedObject var groupViewModel: GroupViewModel
    
        var body: some View {
            List(groupViewModel.itemVMs) { itemVM in
                ItemView(itemVM: itemVM)
            }
        }
    }
}
