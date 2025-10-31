//
//  SwiftUIAutoLayoutApp.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 09.06.2025.
//

import SwiftUI

@main
struct SwiftUIAutoLayoutApp: App {
    
    init() {
        DBGenerator().generateIfNeeded()
    }
    
    var body: some Scene {
        WindowGroup {
            Mirror_KVC.ContentView()
                .environment(\.managedObjectContext, CoreDataStack.shared.managedContext)

        }
    }
}
