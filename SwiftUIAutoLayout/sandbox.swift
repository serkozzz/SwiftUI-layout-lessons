//
//  sandbox.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 29.06.2025.
//

import SwiftUI
import Combine


struct sandbox: View {
    

    @State var number = 10
    @State var a = 0
    var body: some View {
        HStack {
            ZoomableScrollView(maxZoomScale: 3, minZoomScale: 0.2) {
                AIPlan2DView()
            }
            .background(.green)
        }
    }
}


struct AIPlan2DView: View {
    var mesh = [ CGPoint(x: 10, y: 10),
                 CGPoint(x: 300, y: 10),
                 CGPoint(x: 300, y: 300),
                 CGPoint(x: 10, y: 300)
    ]
    var padding = 100.0
    private let TOP_LEFT_PADDING = CGPoint(x: 20, y: 20)
    let scale = CGSize(width: 1, height: -1)
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
            MeshView(points: mesh)
                .frame(width: 300, height: 300)
                .background(.yellow)
        }
    }
}


struct MeshView: View {

    var points: [CGPoint]
    var body: some View {
        Path { path in
            guard let first = points.first else { return }
            path.move(to: first)
            for point in points.dropFirst() {
                path.addLine(to: point)
            }
            path.closeSubpath()
        }
        .stroke(.blue, lineWidth: 4)
    }
}
     
     

#Preview {
    sandbox()
}

