import SwiftUI


//based on keyframeAnimator general purpose interpolator

struct KeyFrameInterpolator: View {
    var from: CGFloat
    var to: CGFloat
    var duration: TimeInterval
    var hold: TimeInterval = 0
    var timing: UnitCurve = .easeInOut
    var onUpdate: (CGFloat) -> Void
    var onEnd: (() -> Void)? = nil

    @State private var trigger = false

    var body: some View {
        Color.clear
            .keyframeAnimator(
                initialValue: 0.0,
                trigger: trigger
            )  { content, value in
                DispatchQueue.main.async {
                    onUpdate(value)
                }
                return content
            } keyframes: { _ in
                CubicKeyframe(to, duration: duration)
                CubicKeyframe(to, duration: hold)
            }
            .onAppear { trigger.toggle() }
            .onChange(of: trigger) {  onEnd?() }
    }
}

struct InterpolatorSample: View {
    @State var value: CGFloat = 0
    var body: some View {
        Group {
            Text("value: \(value)")
            KeyFrameInterpolator(from: 0, to: 100, duration: 1) { value in
                self.value = value
                print(value)
            }
        }
    }
}


#Preview {
    InterpolatorSample()
}
