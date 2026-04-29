import SwiftUI
import UIKit

struct UITextViewWrapper: UIViewRepresentable {
    @Binding var text: String

    var isEditable: Bool = true
    var isScrollEnabled: Bool = true
    var font: UIFont = .preferredFont(forTextStyle: .body)
    var textColor: UIColor = .label

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }

        uiView.isEditable = isEditable
        uiView.isScrollEnabled = isScrollEnabled
        uiView.font = font
        uiView.textColor = textColor
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        @Binding private var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
    }
}
