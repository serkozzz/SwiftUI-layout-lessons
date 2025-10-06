//
//  CoordinatorSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 06.10.2025.
//

import SwiftUI

///Попытка повторить близкий к козловскому паттерн координатор в SwiftUI
///ЗАДОЛБАЛСЯ С ЭТИМ ПРИМЕРОМ, НЕ НУЖНО ЭТО ТЕБЕ, НЕ ДЕЛАЙ
///
@MainActor
private enum AppRouter: Hashable {
    case main
    case detail(String)
    case detailOfDetail(String)
}

///класс роутера нужен только обертка path, чтобы можно было спокойно передавать между координаторами, хранить не как State и не ебаться с Binding
@MainActor
private final class Router: ObservableObject {
    @Published var path: [AppRouter] = []

    func push(_ route: AppRouter) {
        path.append(route)
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}

@MainActor
private final class RootCoordinator: ObservableObject {
    private let router: Router
    private lazy var detailsCoordinator = DetailCoordinator(router: router)

    init(router: Router) {
        self.router = router
    }

    func showDetail(text: String) {
        router.push(.detail(text))
    }

    @ViewBuilder
    func createView(router route: AppRouter) -> some View {
        switch route {
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
    private let router: Router

    init(router: Router) {
        self.router = router
    }

    func showDetailOfDetail(text: String) {
        router.push(.detailOfDetail(text))
    }

    func goBack() {
        router.pop()
    }

    func popToRoot() {
        router.popToRoot()
    }
}

struct CoordinatorSample: View {
    @StateObject private var router: Router
    @StateObject private var coordinator: RootCoordinator

    init() {
        // Создаём один Router и передаём его и в координатор, и в NavigationStack
        let router = Router()
        _router = StateObject(wrappedValue: router)
        _coordinator = StateObject(wrappedValue: RootCoordinator(router: router))
    }

    var body: some View {
        // NavigationStack нужен Binding к пути — собираем его из router.path
        NavigationStack(path: Binding(get: { router.path }, set: { router.path = $0 })) {
            MainView()
                .navigationDestination(for: AppRouter.self) { route in
                    coordinator.createView(router: route)
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
            Button("Back") {
                coordinator.goBack()
            }
            Button("Pop to root") {
                coordinator.popToRoot()
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
            Button("Back") {
                coordinator.goBack()
            }
        }
    }
}

#Preview {
    CoordinatorSample()
}
