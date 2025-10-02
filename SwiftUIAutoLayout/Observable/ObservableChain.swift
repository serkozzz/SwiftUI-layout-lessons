

import SwiftUI
import Combine

@MainActor
private class Wheel: ObservableObject {
    @Published var pressure = 100
}

@MainActor
private class MyCar: ObservableObject {
    @ObservedObject var wheel: Wheel = Wheel()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.wheel.$pressure.sink() { value in
            self.objectWillChange.send()
        }.store(in: &cancellables)
    }
}

private struct ContentView: View {
    @ObservedObject var car = MyCar()
    var body: some View {
        print ("body")
        return VStack {
            Text("Hello, pressure = \(car.wheel.pressure)")
            Button("tap") {
                car.wheel.pressure += 1
            }
        }
    }
}

 struct ObservableChainSample_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

