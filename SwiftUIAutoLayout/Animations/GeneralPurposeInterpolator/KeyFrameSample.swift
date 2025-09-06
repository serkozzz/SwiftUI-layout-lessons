import SwiftUI

struct KeyFrameSample: View {
    @State private var trigger = false     // перезапуск анимации
    @State private var t: CGFloat = 0      // сюда кладём промежуточное значение
    @State private var computed: CGFloat = 0

    var body: some View {
        VStack(spacing: 16) {
            Text("t = \(t, specifier: "%.3f")")
            Text("sin(t·π) = \(computed, specifier: "%.3f")")

            Button("Play 0 → 1 → 0") {
                trigger.toggle()            // перезапустим анимацию
            }
        }
        .overlay {
            // Ничего не рисуем; используем аниматор как «эмиттер» значений
            Color.clear
                .keyframeAnimator(
                    initialValue: 0.0,
                    trigger: trigger
                ) { content, value in
                    // value — текущее интерполированное значение на кадре
                    DispatchQueue.main.async {
                        t = value
                        computed = sin(value * .pi) // любые расчёты
                    }
                    return content // ничего не меняем визуально
                } keyframes: { _ in
                    // 0 → 1 за 1 cек, затем удержим 1 и вернёмся 1 → 0 за 1 сек
                    CubicKeyframe(1.0, duration: 1.0)
                    CubicKeyframe(1.0, duration: 0.2) // «постояли» на 1
                    CubicKeyframe(0.0, duration: 1.0)
                }
                .allowsHitTesting(false)
        }
        .onAppear { trigger.toggle() }
    }
}

#Preview {
    KeyFrameSample()
}
