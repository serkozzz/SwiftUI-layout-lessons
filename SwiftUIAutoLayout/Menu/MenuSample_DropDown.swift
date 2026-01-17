//
//  SourcePicker.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 17.01.2026.
//

import SwiftUI

extension MenuSample {
    
    struct DropDownSample: View {
        
        @Binding var selected: Modulation.Source?
        var body: some View {
            Menu {
                ForEach(Modulation.Source.allCases) { source in
                    Button(source.rawValue) {
                        selected = source
                    }
                }
            } label: {
                Text(selected?.rawValue ?? "Select source")
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
            }
        }
    }
}



#Preview {
    @Previewable @State var selectedItem: MenuSample.Modulation.Source? 
    MenuSample.DropDownSample(selected: $selectedItem)
}
