//
//  ContentView.swift
//  ScrollSandbox
//
//  Created by Sergey Kozlov on 29.04.2026.
//

import SwiftUI

enum KeyboardAndAutoScrollSample {
    struct ContentView: View {
        @State var showSheet = false
        var body: some View {
            Button("tap me") {
                showSheet = true
            }
            .sheet(isPresented: $showSheet) {
                SheetView()
            }
        }
    }
}

#Preview {
    KeyboardAndAutoScrollSample.ContentView()
}
