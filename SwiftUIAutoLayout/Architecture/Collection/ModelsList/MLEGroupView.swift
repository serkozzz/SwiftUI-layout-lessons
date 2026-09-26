//
//  ViewModelsListExample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 26.09.2026.
//

import SwiftUI
import Combine

extension ModelsListExample {
    
    struct GroupView: View {
        
        @ObservedObject var groupViewModel: GroupViewModel
    
        var body: some View {
            List(groupViewModel.items) { item in
                ItemView(item: item)
            }
        }
    }
}
