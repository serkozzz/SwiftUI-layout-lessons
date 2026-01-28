//
//  ContentView.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 28.01.2026.
//

import SwiftUI

enum SegmentedControlSample {
    struct ContentView: View {
        
        @State private var selectedTab: Int = 0
        private let pages: [Color] = [.green, .brown, .blue]
        
        var body: some View {
            VStack(spacing: 16) {
                SegmentedControlView(
                    titles: ["tab1", "tab2", "tab3"],
                    selectedIndex: $selectedTab,
                    selectedColor: .accentColor,
                    textSelectedColor: .white,
                    textUnselectedColor: .primary
                )
                pages[selectedTab]
                    .ignoresSafeArea(edges: .bottom)
            }
            .padding()
        }
    }
}



#Preview {
    SegmentedControlSample.ContentView()
}
