//
//  AdaptivePopover.swift
//  Screenplay
//
//  Created by Aleksandr Kozlov on 10.09.2025.
//

import SwiftUI

struct AdaptivePopover<PopoverContent: View>: ViewModifier {
    @State private var height: CGFloat = 0
    
    @Binding var isPresented: Bool
    var attachmentAnchor: PopoverAttachmentAnchor?
    var fixedWidth: CGFloat?
    var maxWidth: CGFloat?
    @ViewBuilder var popoverContent: PopoverContent
    
    func body(content: Content) -> some View {
        if let attachmentAnchor {
            content
                .popover(
                    isPresented: $isPresented,
                    attachmentAnchor: attachmentAnchor,
                    content: { innerPopoverContent }
                )
        } else {
            content
                .popover(
                    isPresented: $isPresented,
                    content: { innerPopoverContent }
                )
        }
        
    }
    
    private var innerPopoverContent: some View {
        ZStack {
            popoverContent
                .fixedSize(horizontal: false, vertical: true)
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            height = geo.size.height
                        }
                    }
                }
                .frame(width: fixedWidth, height: height)
                .frame(maxWidth: maxWidth)
        }
    }
}

extension View {
    
    func adaptivePopover(
        isPresented: Binding<Bool>,
        fixedWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        content: () -> some View
    ) -> some View {
        modifier(
            AdaptivePopover(
                isPresented: isPresented,
                fixedWidth: fixedWidth,
                maxWidth: maxWidth,
                popoverContent: content,
            )
        )
    }
    
    func adaptivePopover(
        isPresented: Binding<Bool>,
        attachmentAnchor: PopoverAttachmentAnchor,
        fixedWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        content: () -> some View
    ) -> some View {
        modifier(
            AdaptivePopover(
                isPresented: isPresented,
                attachmentAnchor: attachmentAnchor,
                fixedWidth: fixedWidth,
                maxWidth: maxWidth,
                popoverContent: content,
            )
        )
    }
}


struct AdaptivePopoverSample: View {
    @State private var isPresented = false
    @State private var text = "X X  x x x x x  sdf sdf sdf sdf sdf sdfs dfsd fsdf sdf sdf sdf sdf sdf sdf sdf sdfsd fsdf sdfsdfdsxfc sadfas fasd fasd fasdf asdf X"
    @State private var size: CGSize = .zero
    
    var body: some View {
        VStack {
            Button("Popover") {
                isPresented = true
            }
            .adaptivePopover(isPresented: $isPresented,
                             maxWidth: 500) {
                VStack {
                    Text(text)
                    Text("Hello")
                }
                .presentationCompactAdaptation(.popover)
                .padding()
            }
        }
//        .task {
//            while true {
//                try? await Task.sleep(for: .seconds(2))
//                text = Array(repeating: "X", count: Int.random(in: 0..<50)).joined(separator: " ")
//            }
//        }
    }
}


#Preview {
    AdaptivePopoverSample()
}

