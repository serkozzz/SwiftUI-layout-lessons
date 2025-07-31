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


//пример контейнера который инкапсулирует логику, которая может быть только во вью(зависимость от environment)
//при этом не может быть в расширении или просто глоб фун-ции из за необходимости объявить хранимое св-во
//результат работы этой логики передается в качестве параметра в замыкание которое получает контейнер.

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
                            .frame(maxHeight: .infinity)
                        Image(systemName: "minus").resizable().aspectRatio(contentMode: .fit)
                            .frame(maxHeight: .infinity)
                    }
                }
                else {
                    HStack {
                        Image(systemName: "plus").resizable().aspectRatio(contentMode: .fit)
                            .frame(maxHeight: .infinity)
                        Image(systemName: "minus").resizable().aspectRatio(contentMode: .fit)
                            .frame(maxHeight: .infinity)
                    }
                }
            }
        }
    }
}



