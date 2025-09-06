//
//  UseAnimCurveWithoutVisualization.swift
//  sandbox
//
//  Created by Sergey Kozlov on 06.09.2025.
//

import SwiftUI



import SwiftUI

private class PhysicsModel {
    var velocity: CGFloat
    var position: CGFloat // Не анимируется напрямую, вычисляется
    
    init(velocity: CGFloat, position: CGFloat) {
        self.velocity = velocity
        self.position = position
    }
    
    func calculatePosition(at time: TimeInterval) -> CGFloat {
        return position + velocity * CGFloat(time)
    }
}

struct NoVisualization: View {
     
    private var model: PhysicsModel
    @State private var isAnimated: Bool = false
    @State private var timer: Timer?
    @State private var totalDuration: Double = 1
    
    init() {
        //_model = .init(wrappedValue: PhysicsModel(velocity: 0, position: 0))
        model = PhysicsModel(velocity: 0, position: 0)
    }
    
    var body: some View {
        print("Body called") // Логируем вызов body
        return VStack {
            
            Text("Velocity: \(model.velocity, specifier: "%.2f")")
            Text("Position: \(model.position, specifier: "%.2f")")
            Button("Start Animation") {
                isAnimated = true
                Task {
                    try await Task.sleep(for: .seconds(totalDuration))
                    isAnimated = false
                }
            }
        }
        .onChange(of: isAnimated) {
            if (isAnimated) {
               timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { timer in
                   Task { @MainActor in
                       model.position = model.calculatePosition(at: 1/60)
                   }
                }
            }
            else {
                timer?.invalidate()
            }
        }
        .keyframeAnimator(initialValue: model, trigger: isAnimated) { content, value in
            print(value.velocity)
            return content
        }
        keyframes: { _ in
            KeyframeTrack(\.velocity) {
                LinearKeyframe(1, duration: totalDuration / 2)
                LinearKeyframe(0, duration: totalDuration / 2)
            }
            
        }
        
    }
}

struct NoVisualization_Preview: PreviewProvider {
    static var previews: some View {
        NoVisualization()
    }
}

