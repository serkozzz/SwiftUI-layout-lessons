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
}

struct SingletonWithStrictConcurrencySample: View {

    var body: some View {
        VStack {
            Text("Hello")
        }
        .onAppear() {
            MyCar.shared.speed = 10
            print(99)
            print("MyCar.shared \(MyCar.shared.speed)")
        }
    }
}

#Preview {
    SingletonWithStrictConcurrencySample()
}
