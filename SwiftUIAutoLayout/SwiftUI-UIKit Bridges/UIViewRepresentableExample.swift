//
//  UIViewRepresentableExample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 19.08.2025.
//

import SwiftUI


struct TextFieldView: UIViewRepresentable {
    
    @Binding var text: String
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> TextViewCoordinator {
        Coordinator(self)
    }
}


class TextViewCoordinator: NSObject, UITextFieldDelegate {
    var parent: TextFieldView
    
    init(_ parent: TextFieldView) {
        self.parent = parent
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        parent.text = textField.text!
    }
}



struct UIViewRepresentableExample: View {
    
    @FocusState private var isTextEditorFocused: Bool
    @State var text: String = "2025"
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .hideKeyboardOnTap()
            
            VStack {
                HStack {
                    Text("UIKit: ")
                    TextFieldView(text: $text)
                        .focusable(isTextEditorFocused)
                        .fixedSize()
                }
                HStack {
                    Text("SwiftUI: ")
                    Text(text).fixedSize()
                }
                .padding()
                Button("Set text 1984") {
                    text = "1984"
                }
            }
        }
    }
}


#Preview {
    UIViewRepresentableExample()
}


extension View {
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}
