//
//  MenuSample_Sheet.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 17.01.2026.
//



import SwiftUI

extension MenuSample {
    struct SheetMenu : View {
        @State private var showMenu: Bool = false
        @Binding var selectedItem: Modulation.Source?

        var body: some View {

            Button(selectedItem?.rawValue ?? "Select source") {
                showMenu = true
            }
            .sheet(isPresented: $showMenu) {
                List {
                    ForEach(Modulation.Source.allCases) { item in
                        Button {
                            selectedItem = item
                            showMenu = false
                        } label: {
                            Text(item.rawValue)
                        }
                    }
                }
                .presentationDetents([.medium])
            }
        }
    }
}


 
#Preview {
    @Previewable @State var selectedItem: MenuSample.Modulation.Source?
    MenuSample.SheetMenu(selectedItem: $selectedItem)
}
