//
//  MyView.swift
//  ScrollSandbox
//
//  Created by Sergey Kozlov on 29.04.2026.
//

import SwiftUI





extension KeyboardAndAutoScrollSample {
        
    /*пример имеет смысл только как шпаргалка как сделать автоскрол
     в большинстве случаев если у вас всё на SwiftUI - просто добавляете скролл и ситема сама проскролит к вашему текстовому полю при появлении клавиатуры.
     В данном примере решается конкретная проблема - когда у нас не свифтui контейнер, а обертка над UITextView - система не скролит автоматом.
     */
    struct SheetView: View {
        @State private var text = "Type here..."
        
        var body: some View {
            ScrollViewReader { proxy in
                VStack(spacing: 12) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Header")
                            rect
                            uiTextView
                            Text("End")
                                .id("end")
                        }
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        withAnimation(.easeOut(duration: 0.25)) {
                            proxy.scrollTo("end", anchor: .bottom)
                        }
                    }
                }
            }
            .padding()
        }
        
        var uiTextView: some View {
            UITextViewWrapper(text: $text)
                .frame(height: 120)
        }
        
        var rect: some View {
            Rectangle()
                .fill(.yellow)
                .frame(height: 300)
        }
    }
}
#Preview {
    KeyboardAndAutoScrollSample.ContentView()
}
