import SwiftUI

enum AlertQueueDemoAlertType: Identifiable {
    case first
    case second

    var id: Int {
        switch self {
        case .first: return 0
        case .second: return 1
        }
    }
}

final class AlertQueueDemoViewModel: ObservableObject {
    @Published var alertToShow: AlertQueueDemoAlertType?
    @Published var errorToShow: UIError?

    private var queue: [AlertQueueDemoAlertType] = []

    func startFlow() {
        queue.removeAll()
        queue.append(.first)
        queue.append(.second)
        showNextAlertFromQueue()
    }

    func showNextAlertFromQueue() {
        if let next = queue.isEmpty ? nil : queue.removeFirst() {
            alertToShow = next
            return
        }

        print("alerts finished")
        //here shoud be code you want to continue after all alerts, in RoomBuilder it was delegae call
    }
}

