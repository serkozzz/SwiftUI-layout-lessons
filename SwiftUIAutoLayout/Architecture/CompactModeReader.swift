//
//  CompactModeReader.swift
//  Screenplay
//
//  Created by Sergey Kozlov on 31.07.2025.
//

import SwiftUI

@MainActor
private func isCompactMode(vertical: SwiftUI.UserInterfaceSizeClass?) -> Bool {
    UIDevice.current.userInterfaceIdiom == .phone && vertical == .regular
}

struct CompactModeReader<Content: View>: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var content: (Bool) -> Content
    
    var body: some View {
        let isCompactMode = isCompactMode(vertical: verticalSizeClass)
        return content(isCompactMode)
    }
}


struct CompactModeReaderExample: View {
    var body: some View {
        
        CompactModeReader { isCompactMode in
            Group {
                if (isCompactMode) {
                    VStack {
                        Image(systemName: "plus").resizable().aspectRatio(contentMode: .fit)
                        Image(systemName: "minus").resizable().aspectRatio(contentMode: .fit)
                    }
                }
                else {
                    HStack {
                        Image(systemName: "plus").resizable().aspectRatio(contentMode: .fit)
                        Image(systemName: "minus").resizable().aspectRatio(contentMode: .fit)
                    }
                }
            }
        }
    }
}
