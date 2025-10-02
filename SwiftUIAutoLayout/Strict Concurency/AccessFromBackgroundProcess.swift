//
//  AccessFromBackgroundProcess.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 01.10.2025.
//

import SwiftUI


private struct MyCar {
    var speed: Int = 100
}

struct AccessFromBackgroundProcessSample: View {
    @State private var car = MyCar()
    
    var body: some View {
        VStack {
        }
        .onAppear() {
            Task.detached { [car] in
                print (car.speed)
            }
        }
    }
}

#Preview {
    AccessFromBackgroundProcessSample()
}
