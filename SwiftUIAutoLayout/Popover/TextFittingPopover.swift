//
//  SelfSizedTextPopover.swift
//  sandbox
//
//  Created by Sergey Kozlov on 02.09.2025.
//

import SwiftUI

struct TextFittingPopover: ViewModifier {
    
    @Binding var isPresented: Bool
    private let text: String
    private let backgroundColor: Color
    private let width: CGFloat?
    
    
    @State private var height: CGFloat = 0
    
    
    init(text: String, isPresented: Binding<Bool>, backgroundColor: Color, width: CGFloat?) {
        _isPresented = isPresented
        self.text = text
        self.width = width
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {

        content
        .popover(isPresented: $isPresented,
                 attachmentAnchor: .point(.top),
                 content: {
            ZStack {
                Text(text)
                    .padding()

                    .fixedSize(horizontal: false, vertical: true)
                    .presentationCompactAdaptation(.popover)
                    .overlay {
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                self.height = geo.size.height
                            }
                        }
                    }
                    .frame(width: width, height: self.height)
            }
            .presentationBackground {
                ContainerRelativeShape()                // форма самого поповера
                    .fill(backgroundColor)              // твой цвет на «весь поповер»
            }
        })
    }
}

extension View {
    func textFittingPopover(text: String, isPresented: Binding<Bool>, backgroundColor: Color, width: CGFloat? = nil) -> some View {
        self.modifier(TextFittingPopover(text: text, isPresented: isPresented, backgroundColor: backgroundColor, width: width))
    }
}
