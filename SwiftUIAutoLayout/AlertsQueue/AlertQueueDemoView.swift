import SwiftUI

struct AlertQueueDemoView: View {
    @StateObject private var model = AlertQueueDemoViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("Alert Queue Demo")
                    .font(.headline)

                Button("Start") {
                    model.startFlow()
                }
                .buttonStyle(.borderedProminent)
            }

            Color.clear
                .alert(item: $model.errorToShow) { err in
                    Alert(
                        title: Text("Error"),
                        message: Text(err.message),
                        dismissButton: .cancel(Text("OK"))
                    )
                }
        }
        .alert(item: $model.alertToShow) { alert in
            switch alert {
            case .first:
                return Alert(
                    title: Text("First alert"),
                    message: Text("This is first in queue"),
                    dismissButton: .default(Text("Next")) {
                        model.showNextAlertFromQueue()
                    }
                )
            case .second:
                return Alert(
                    title: Text("Second alert"),
                    message: Text("This is second in queue"),
                    dismissButton: .default(Text("Finish")) {
                        model.showNextAlertFromQueue()
                    }
                )
            }
        }
    }
}

#Preview {
    AlertQueueDemoView()
}

