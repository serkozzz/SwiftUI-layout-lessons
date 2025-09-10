

import SwiftUI



struct ClockView: Shape {
    var angle: Float
    var radius: Float
    
    var animatableData: AnimatablePair<Float, Float> {
        get { AnimatablePair(angle, radius) }
        set {
            angle = newValue.first
            radius = newValue.second
        }
    }
    

    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rectCenter = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: rectCenter)
        let x = rectCenter.x + CGFloat(cos(angle) * radius)
        
        let y = rectCenter.y + CGFloat(sin(angle) * radius)
        
        path.addLine(to: CGPoint(x: x, y: y))
        return path
    }
}


struct ClockViewSample: View {
    @State var angle: Float = 0
    @State var radius: Float = 100
    
    var body: some View {
        VStack {
            ClockView(angle: angle, radius: radius)
                .stroke()
                .frame(width: 200, height: 200)
                .background(.yellow)
            
            Button("start") {                 withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                angle = .pi * 2
                radius = 20
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ClockViewSample()
    }
}
