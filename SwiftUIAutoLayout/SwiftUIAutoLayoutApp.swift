//
//  SwiftUIAutoLayoutApp.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 09.06.2025.
//

import SwiftUI

@main
struct SwiftUIAutoLayoutApp: App {
    var body: some Scene {
        WindowGroup {
            PreferencesWithoutGeometryReader()
        }
    }
}
