//
//  sandbox.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 29.06.2025.
//

import SwiftUI


private class Car : ObservableObject {
    @Published var speed: Int
    
    init(speed: Int = 60) {
        self.speed = speed
    }
}

private struct CarView: View {
    
    @Binding var car: Car
    
    var body: some View {
        Text("car speed = \(car.speed)")
    }
}

struct sandbox: View {
    
    @State private var car = Car()
    
    
    var body: some View {
        VStack {
            Rectangle().fill(.red)
                
        }
    }
}

#Preview {
    sandbox()
}
