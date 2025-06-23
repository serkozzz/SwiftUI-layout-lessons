//
//  PreferencesWithoutGeometryReader.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 23.06.2025.
//

import SwiftUI

private struct ColorKey: PreferenceKey {
    static let defaultValue: Color? = nil
    
    static func reduce(value: inout Color?, nextValue: () -> Color?) {
        value = value ?? nextValue()
    }
}


struct PreferencesWithoutGeometryReader: View {
    
    @State var color = Color.red
    var body: some View {
        Button {
            color = .green
        }label: {
            TextWrapper()
                .preference(key: ColorKey.self, value: color)
        }
        .onPreferenceChange(ColorKey.self) { c in
            print(c)
        }
    }
}

struct TextWrapper: View {
    init() {
        print("TextWrapper init")
    }
    var body: some View {
        Text("Tap")
    }
}


#Preview {
    PreferencesWithoutGeometryReader()
}
