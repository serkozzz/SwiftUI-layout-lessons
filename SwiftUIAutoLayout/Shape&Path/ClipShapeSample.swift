//
//  ContentView.swift
//  sandbox
//
//  Created by Sergey Kozlov on 02.09.2025.
//

import SwiftUI


struct ClipShapeSample: View {
    
    var body: some View {
        VStack {
            Text("Hello World, It is me!")
            Button ("Button") {}.buttonStyle(.borderedProminent)
            Button ("Button") {}.buttonStyle(.borderedProminent)
        }
            .background(.yellow)
            .clipShape(myShape())
    }
}


struct myShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return path.applying(
            CGAffineTransform(translationX: center.x, y: center.y)
                .rotated(by: .pi) // 180°
                .translatedBy(x: -center.x, y: -center.y)
        )
    }
}

#Preview {
    ClipShapeSample()
}
