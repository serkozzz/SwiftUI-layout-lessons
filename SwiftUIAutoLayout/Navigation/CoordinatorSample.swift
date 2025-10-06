//
//  CoordinatorSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 06.10.2025.
//

import SwiftUI

@MainActor
private enum AppRouter: Hashable {
    case main
    case detail(String)
    case detailOfDetail(String)
}

@MainActor
private final class RootCoordinator: ObservableObject {
    // Единый источник правды для стека навигации
    @Published var path: [AppRouter] = []

    // Создаётся лениво после полной инициализации self
    private lazy var detailsCoordinator = DetailCoordinator(root: self)

    func showDetail(text: String) {
        path.append(.detail(text))
    }

    @ViewBuilder
    func createView(router: AppRouter) -> some View {
        switch router {
        case .main:
            MainView()
        case .detail(let detailText):
            DetailView(detailText: detailText)
                .environmentObject(detailsCoordinator)
        case .detailOfDetail(let detailText):
            DetailOfDetailView(detailText: detailText)
                .environmentObject(detailsCoordinator)
        }
    }
}

@MainActor
private final class DetailCoordinator: ObservableObject {
    // RootCoordinator владеет DetailCoordinator; цикла нет из‑за unowned
    unowned let root: RootCoordinator

    init(root: RootCoordinator) {
        self.root = root
    }

    func showDetailOfDetail(text: String) {
        root.path.append(.detailOfDetail(text))
    }
}

struct CoordinatorSample: View {
    @StateObject private var coordinator = RootCoordinator()

    var body: some View {
        // Для ObservableObject создаём биндинг вручную
        NavigationStack(path: Binding(get: { coordinator.path }, set: { coordinator.path = $0 })) {
            MainView()
                .navigationDestination(for: AppRouter.self) { router in
                    coordinator.createView(router: router)
                }
                .environmentObject(coordinator)
        }
    }
}

private struct MainView: View {
    @EnvironmentObject var coordinator: RootCoordinator
    var body: some View {
        VStack {
            Text("Main")
            Button("detail") {
                coordinator.showDetail(text: "E-ge-gei")
            }
        }
    }
}

private struct DetailView: View {
    @EnvironmentObject var coordinator: DetailCoordinator
    var detailText: String
    var body: some View {
        VStack {
            Text("Detail:")
            Text(detailText)
            Button("new View") {
                coordinator.showDetailOfDetail(text: "3d level")
            }
        }
    }
}

private struct DetailOfDetailView: View {
    @EnvironmentObject var coordinator: DetailCoordinator
    var detailText: String
    var body: some View {
        VStack {
            Text("DetailOfDetailView:")
            Text(detailText)
        }
    }
}

#Preview {
    CoordinatorSample()
}
