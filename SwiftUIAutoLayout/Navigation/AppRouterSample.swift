//
//  AppRouterSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 06.10.2025.
//

import SwiftUI

@MainActor
private enum AppRouter : Hashable{
    case detail(String)
    case main

    @ViewBuilder
    func createView(path: Binding<NavigationPath>) -> some View {
        switch self {
        case .main:
            MainView(path: path)
        case .detail(let detailText):
            DetailView(path: path, detailText: detailText)
        }
    }
}

//don't try to start with path.router(AppRouter.main)
//just start with placing MainView(start View) manually
//all next moves make via path
struct AppRouterSample: View {
    
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            MainView(path: $path)
            .navigationDestination(for: AppRouter.self) { router in
                router.createView(path: $path)
            }
        }
    }
}

private struct MainView: View {
    @Binding var path: NavigationPath
    var body: some View {
        Text("Main")
        Button("detail") {
            path.append(AppRouter.detail("E-ge-gei"))
        }
    }
}

private struct DetailView: View {
    @Binding var path: NavigationPath
    var detailText: String
    var body: some View {
        Text("Detail:")
        Text(detailText)
    }
}

#Preview {
    AppRouterSample()
}
