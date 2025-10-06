//
//  AccessFromBackgroundProcess.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 01.10.2025.
//

import SwiftUI

//private class MySingleton {
//    static let shared = MySingleton()
//    var speed: Int = 100
//}


private class MyCar: @unchecked Sendable {
    var speed = 100
}

struct AccessFromMainContextSample: View {

    var body: some View {
        VStack {
            Text("Hello")
        }
        .onAppear() {
            Task.detached {
                var car = MyCar()
                Task { @MainActor in
                    print(car.speed)
                }
                car.speed = 90
            }
        }
    }
}

#Preview {
    AccessFromMainContextSample()
}
