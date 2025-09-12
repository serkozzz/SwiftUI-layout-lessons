//
//  ContentView.swift
//  sandbox
//
//  Created by Sergey Kozlov on 02.09.2025.
//

import SwiftUI


struct TrimShapeAnimSample: View {
    @State var progress: CGFloat = 1
    @State var isTrimEnabled = false
    let animationID = UUID()
    
    var body: some View {
        MyShape()
            .trim(from: 0, to: progress)
            .stroke()
            .frame(width: 200, height: 100)
            .background(.yellow)
            .onAppear() {
                if (isTrimEnabled) {
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: true)) {
                        progress = 0
                    }
                }
                else {
                    progress = 1
                }
            }
            .id(isTrimEnabled ? animationID: UUID())
        Button("toggle") {
            isTrimEnabled.toggle()
        }
    }
}


struct MyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}

#Preview {
    TrimShapeAnimSample()
}
