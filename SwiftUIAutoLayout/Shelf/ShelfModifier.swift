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
            return .init(resizeMode: .squeeze, shelfPosition: .bottomShelf)
        }
        return .init(resizeMode: .squeeze, shelfPosition: .leftShelf)
    }
}

private let GRABBER_THICKNESS: CGFloat = 12

struct ShelfModifier<Item: Identifiable, ShelfContent: View>: ViewModifier {
    
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    
    @Binding var item: Item?
    let shelfContent: (Item) -> ShelfContent
    
    @State private var heightWhenStartGrab: CGFloat?
    @State private var currentHeight: CGFloat = 0
    private var MAX_HEIGHT: CGFloat
    private var MIN_HEIGHT: CGFloat
    private var MAX_WIDTH: CGFloat
    private var MIN_WIDTH: CGFloat

    
    @State private var widthWhenStartGrab: CGFloat?
    @State private var currentWidth: CGFloat = 0
    
    @State private var currentOffset: CGFloat = 0
    
    private let heightDetents = [GRABBER_THICKNESS, 200.0, 300, 400]
    private let widthDetents = [GRABBER_THICKNESS, 200.0, 300, 400]
    
    init(item: Binding<Item?>, shelfContent: @escaping (Item) -> ShelfContent) {
        self._item = item
        self.shelfContent = shelfContent
        currentHeight = CGFloat(heightDetents[1])
        MAX_HEIGHT = heightDetents.max()!
        MIN_HEIGHT = heightDetents.min()!
        currentWidth = CGFloat(widthDetents[1])
        MAX_WIDTH = widthDetents.max()!
        MIN_WIDTH = widthDetents.min()!
    }
    
    func body(content: Content) -> some View {
        let presentationStyle = ShelfPresentationStyle.choose(hSizeClass: hSizeClass, vSizeClass: vSizeClass)
        Group {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                if presentationStyle.shelfPosition == .bottomShelf {
                    bottomShelf(resizeMode: presentationStyle.resizeMode)
                }
            }
            .safeAreaInset(edge: .leading, spacing: 0) {
                if presentationStyle.shelfPosition == .leftShelf {
                    leftShelf(resizeMode: presentationStyle.resizeMode)
                }
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
                Group {
                    if (currentHeight <= MIN_HEIGHT)
                    {
                        Color(uiColor: UIColor.secondarySystemBackground)
                    }
                    else {
                        shelfContent(item)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: resizeMode == .offset ? MAX_HEIGHT : max(0, currentHeight - GRABBER_THICKNESS))
            }
            .zIndex(12)
            .offset(y: resizeMode == .offset ? MAX_HEIGHT - currentHeight : 0)
            .transition(.move(edge: .bottom))
            .background(Color(uiColor: UIColor.secondarySystemBackground))
        }
    }
    
    private var verticalGrabber: some View {
        ShelfGrabber(isHighlighted: heightWhenStartGrab != nil)
            .frame(maxWidth: .infinity)
            .frame(height: GRABBER_THICKNESS)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
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
                Group {
                    if (currentHeight <= MIN_HEIGHT)
                    {
                        Color(uiColor: UIColor.secondarySystemBackground)
                    }
                    else {
                        shelfContent(item)
                            .frame(maxHeight: .infinity)
                    }
                }
                .frame(width: resizeMode == .offset ? MAX_WIDTH : max(0, currentWidth - GRABBER_THICKNESS))
                horizontalGrabber
            }
            
            .offset(x: resizeMode == .offset ? currentWidth - MAX_WIDTH : 0)
            .transition(.move(edge: .leading))
            .background(Color(uiColor: UIColor.secondarySystemBackground))
            .zIndex(12)
        }
    }
    
    var horizontalGrabber: some View {
        ShelfGrabber(isHighlighted: widthWhenStartGrab != nil)
            .rotationEffect(Angle(degrees: 90))
            .frame(maxHeight: .infinity)
            .frame(width: GRABBER_THICKNESS)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
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
