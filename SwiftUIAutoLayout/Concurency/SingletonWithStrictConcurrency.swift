//
//  Untitled.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 02.10.2025.
//

import SwiftUI

private actor MyCar  {
    static let shared = MyCar()
    var speed: Int = 100
    
    func setSpeed(speed: Int) async {
        self.speed = speed
    }
}

struct SingletonWithStrictConcurrencySample: View {

    var body: some View {
        VStack {
            Text("Hello")
        }
        .onAppear() {
            Task {
                await MyCar.shared.setSpeed(speed: 99)
                print("MyCar.shared \(await MyCar.shared.speed)")
            }
        }
    }
}

#Preview {
    SingletonWithStrictConcurrencySample()
}
