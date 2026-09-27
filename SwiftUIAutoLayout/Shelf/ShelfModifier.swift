//
//  CustomSheetModifier.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 20.09.2026.
//

import SwiftUI

private enum ResizeMode {
    case squeeze
    case offset
}

private enum ShelfPosition {
    case bottomShelf
    case leftShelf
}

private struct ShelfPresentationStyle {
    var resizeMode: ResizeMode
    var shelfPosition: ShelfPosition
    
    static func choose(hSizeClass: UserInterfaceSizeClass?,
                                        vSizeClass: UserInterfaceSizeClass?) -> ShelfPresentationStyle {
        if vSizeClass == .compact {
            return .init(resizeMode: .squeeze, shelfPosition: .leftShelf)
        }
        if hSizeClass == .compact {
            return .init(resizeMode: .offset, shelfPosition: .bottomShelf)
        }
        return .init(resizeMode: .squeeze, shelfPosition: .leftShelf)
    }
}


struct ShelfModifier<Item: Identifiable, ShelfContent: View>: ViewModifier {
    
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    
    @Binding var item: Item?
    let shelfContent: (Item) -> ShelfContent
    
    @State private var heightWhenStartGrab: CGFloat?
    @State private var currentHeight: CGFloat = 0
    @State private var MAX_HEIGHT: CGFloat
    @State private var MAX_WIDTH: CGFloat
    
    @State private var widthWhenStartGrab: CGFloat?
    @State private var currentWidth: CGFloat = 0
    
    @State private var currentOffset: CGFloat = 0
    
    private let heightDetents = [0, 200.0, 300, 400]
    private let widthDetents = [0, 200.0, 300, 400]
    
    init(item: Binding<Item?>, shelfContent: @escaping (Item) -> ShelfContent) {
        self._item = item
        self.shelfContent = shelfContent
        currentHeight = CGFloat(heightDetents[1])
        MAX_HEIGHT = heightDetents.max()!
        currentWidth = CGFloat(widthDetents[1])
        MAX_WIDTH = widthDetents.max()!
    }
    
    func body(content: Content) -> some View {
        let presentationStyle = ShelfPresentationStyle.choose(hSizeClass: hSizeClass, vSizeClass: vSizeClass)
        ZStack {
            content
            
            switch presentationStyle.shelfPosition {
            case .bottomShelf:
                bottomShelf(resizeMode: presentationStyle.resizeMode)
            case .leftShelf:
                leftShelf(resizeMode: presentationStyle.resizeMode)
            }
        }
        .zIndex(12)
        .animation(.spring(duration: 0.3), value: item != nil)
    }
    
    @ViewBuilder
    private func bottomShelf(resizeMode: ResizeMode) -> some View {
        if let item {
            VStack {
                verticalGrabber
                shelfContent(item)
                    .frame(maxWidth: .infinity)
                    .frame(height: resizeMode == .offset ? MAX_HEIGHT : currentHeight)
                
            }
            .zIndex(12)
            .offset(y: resizeMode == .offset ? MAX_HEIGHT - currentHeight : 0)
            .transition(.move(edge: .bottom))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    private var verticalGrabber: some View {
        Capsule()
            .fill(.secondary)
            .frame(width: 36, height: 5)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged { value in
                        if heightWhenStartGrab == nil {
                            heightWhenStartGrab = currentHeight
                        }
                        currentHeight = heightWhenStartGrab! - value.translation.height
                        if self.currentHeight < 0 {
                            currentHeight = 0
                        }
                    }
                    .onEnded { value in
                        heightWhenStartGrab = nil
                        withAnimation {
                            let newHeight = heightDetents.min(by: { abs($0 - currentHeight) < abs($1 - currentHeight) })!
                            self.currentHeight = CGFloat(newHeight)
                            if self.currentHeight < 0 {
                                currentHeight = 0
                            }
                        }
                    }
            )
    }
    
    @ViewBuilder
    private func leftShelf(resizeMode: ResizeMode) -> some View {
        if let item {
            HStack {
                shelfContent(item)
                    .frame(maxHeight: .infinity)
                    .frame(width: resizeMode == .offset ? MAX_WIDTH : currentWidth)
                horizontalGrabber
            }
            .offset(x: resizeMode == .offset ? currentWidth - MAX_WIDTH : 0)
            .transition(.move(edge: .leading))
            .zIndex(12)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }
    
    var horizontalGrabber: some View {
        Capsule()
            .fill(.secondary)
            .frame(width: 36, height: 5)
            .rotationEffect(Angle(degrees: 90))
            .frame(maxHeight: .infinity)
            .frame(width: 44)
            
            .contentShape(Rectangle())
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged { value in
                        if widthWhenStartGrab == nil {
                            widthWhenStartGrab = currentWidth
                        
                    }
                        currentWidth = widthWhenStartGrab! + value.translation.width
                        if self.currentWidth < 0 {
                            currentWidth = 0
                        }
                }
                .onEnded { value in
                    widthWhenStartGrab = nil
                    withAnimation {
                        let newWidth = widthDetents.min(by: { abs($0 - currentWidth) < abs($1 - currentWidth) })!
                        self.currentWidth = CGFloat(newWidth)
                        if self.currentWidth < 0 {
                            currentWidth = 0
                        }
                    }
                }
        )
    }
}


extension View {
    func shelf<Item: Identifiable, ShelfContent: View>(
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> ShelfContent
    ) -> some View {
        modifier(ShelfModifier(item: item, shelfContent: content))
    }
}


extension View {
    func shelf<SheetContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        let item = Binding<CustomShelfPresentation?>(
            get: {
                isPresented.wrappedValue
                    ? CustomShelfPresentation()
                    : nil
            },
            set: { newValue in
                isPresented.wrappedValue = newValue != nil
            }
        )

        return shelf(item: item) { _ in
            content()
        }
    }
}

private struct CustomShelfPresentation: Identifiable {
    let id = 0
}
