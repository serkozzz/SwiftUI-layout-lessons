//
//  CoordinatorSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 06.10.2025.
//

import SwiftUI
//
///Попытка повторить близкий к козловскому паттерн координатор в SwiftUI
///ЗАДОЛБАЛСЯ С ЭТИМ ПРИМЕРОМ, НЕ НУЖНО ЭТО ТЕБЕ, НЕ ДЕЛАЙ
///
///
///Пример координатора.
///Вместо NavigationPath используем типизированный подход. Наш NavigationStack будет работать с [AppRoute].
///
///Чтобы не возиться со структурами и биндингом делаем обертку над - AppNavigationPath. Это сильно упростит нам передачу между координаторами и инициализацию (была трабла как проинить RootCoordinator передав в него @State path - когда они оба члены CoordinatorSample: View)
///
///Нужный координатор иньектится через @EnvironmentObject внутри RootCoordinator.createView метода. Первый раз RootCoordinator иньектится вручную в CoordinatorSample:View.


@MainActor
private enum AppRoute: Hashable {
    case main
    case detail(String)
    case detailOfDetail(String)
}

/// Путь навигации приложения (обёртка над массивом маршрутов),
/// чтобы удобно передавать его между координаторами и давать Binding для NavigationStack.
@MainActor
private final class AppNavigationPath: ObservableObject {
    @Published private(set) var path: [AppRoute] = []

    // Готовый биндинг для NavigationStack(path:)
    var binding: Binding<[AppRoute]> {
        Binding(
            get: { self.path },
            set: { self.path = $0 }
        )
    }

    func push(_ route: AppRoute) {
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
    private(set) var path: AppNavigationPath = AppNavigationPath()
    private lazy var detailsCoordinator = DetailCoordinator(path: path)

    func showDetail(text: String) {
        path.push(.detail(text))
    }

    @ViewBuilder
    func createView(for route: AppRoute) -> some View {
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
    private let path: AppNavigationPath

    init(path: AppNavigationPath) {
        self.path = path
    }

    func showDetailOfDetail(text: String) {
        path.push(.detailOfDetail(text))
    }

    func goBack() {
        path.pop()
    }

    func popToRoot() {
        path.popToRoot()
    }
}

struct CoordinatorSample: View {

    // Важно: наблюдаем объект пути, чтобы View обновлялась при push/pop
    @ObservedObject private var path: AppNavigationPath
    @StateObject private var coordinator: RootCoordinator

    init() {
        let coordinator = RootCoordinator()
        _coordinator = StateObject(wrappedValue: coordinator)
        _path = ObservedObject(wrappedValue: coordinator.path)
    }

    var body: some View {
        NavigationStack(path: path.binding) {
            MainView()
                .navigationDestination(for: AppRoute.self) { route in
                    coordinator.createView(for: route)
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
