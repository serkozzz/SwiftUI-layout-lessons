//
//  AnchorTabsExample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 14.06.2025.
//

import SwiftUI

struct BoundsKey: PreferenceKey {
    static let defaultValue: Anchor<CGRect>? = nil
    
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = value ?? nextValue()
    }
}


struct AnchorTabsExample: View {
    
    @State private var selectedTabIndex: Int? = 0
    private let tabNames = ["Tab1", "Tab2222", "Tab3"]
    
    var body: some View {
        VStack {
            //Spacer()
            HStack(spacing: 0) {
                ForEach(tabNames.indices, id: \.self) { i in
                    Tab(name: tabNames[i]) {
                        selectedTabIndex = i
                    }
                    //.background(i == selectedTabIndex ? .green : .white)
                    .anchorPreference(key: BoundsKey.self,
                                      value: .bounds,
                                      transform: { anchor in
                        self.selectedTabIndex == i ? anchor : nil
                    })
                }
            }
            .overlayPreferenceValue(BoundsKey.self, { anchor in
                GeometryReader { proxy in
                    let anchorBounds = proxy[anchor!]
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: anchorBounds.width, height: 2)
                        .offset(x: anchorBounds.minX, y: anchorBounds.maxY - 2)
                        .animation(.default)
                    
                }
            })
        }
        .ignoresSafeArea()
    }
}

struct Tab: View {
    var name: String
    var onTap: (() -> Void)?
    
    var body: some View {
        Button {
            onTap?()
        } label:
        {
            Text(name)
                .padding(10)
                .frame(maxWidth: .infinity)
                //.border(.black)
        }

    }
}


#Preview {
    AnchorTabsExample()
}
