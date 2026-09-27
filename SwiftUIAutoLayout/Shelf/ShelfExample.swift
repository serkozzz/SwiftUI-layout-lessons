//
//  CustomSheetExample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 20.09.2026.
//

import SwiftUI

enum ShelfExample {
    
    struct Preset: Identifiable, Equatable {
        let id = UUID()
        static func == (lhs: Preset, rhs: Preset) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    struct ContentView : View {
        @State private var item: Preset?
        var body: some View {
            VStack {
                Text("Hello, World!")
                
                Button("show shelf") {
                    item = Preset()
                }
            }
            .shelf(item: $item) { item in
                Text("This is custom sheet")
            }
        }
        
        
    }
}

#Preview {
    CustomSheetExample.ContentView()
}
