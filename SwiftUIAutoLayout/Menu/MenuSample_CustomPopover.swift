//
//  MenuSample_CustomPopover.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 17.01.2026.
//

import SwiftUI

extension MenuSample {
    struct CustomPopoverMenu : View {
        @State private var showMenu: Bool = false
        @Binding var selectedItem: Modulation.Source?

        var body: some View {

            Button(selectedItem?.rawValue ?? "Select source") {
                showMenu = true
            }
            .adaptivePopover(isPresented: $showMenu) {
                VStack {
                    ForEach(Modulation.Source.allCases) { item in
                        Button {
                            selectedItem = item
                            showMenu = false
                            print("\(item.rawValue) selected")
                        } label: {
                            Text(item.rawValue)
                        }
                    }
                    
                }
                .padding()
                .presentationCompactAdaptation(.none)
            }
        }
    }
}


 
#Preview {
    @Previewable @State var selectedItem: MenuSample.Modulation.Source?
    MenuSample.CustomPopoverMenu(selectedItem: $selectedItem)
}
