//
//  CustomSheetModifier.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 20.09.2026.
//

import SwiftUI

struct ShelfModifier<Item: Identifiable, ShelfContent: View>: ViewModifier {
    
    enum PresentationStyle {
        case bottomShelf
        case leftShelf
        case fullScreen
        
        
        static func choose(hSizeClass: UserInterfaceSizeClass?,
                                            vSizeClass: UserInterfaceSizeClass?) ->PresentationStyle {
            if vSizeClass == .compact {
                return .leftShelf
            }
            if hSizeClass == .compact {
                return .bottomShelf
            }
            return .leftShelf
        }
    }
    
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    
    @Binding var item: Item?
    let shelfContent: (Item) -> ShelfContent
    
    @State private var heightWhenStartGrab: CGFloat?
    @State private var currentHeight: CGFloat = 0
    
    @State private var widthWhenStartGrab: CGFloat?
    @State private var currentWidth: CGFloat = 0
    
    private let heightDetents = [0, 200.0, 300, 400]
    private let widthDetents = [0, 200.0, 300, 400]
    
    init(item: Binding<Item?>, shelfContent: @escaping (Item) -> ShelfContent) {
        self._item = item
        self.shelfContent = shelfContent
        currentHeight = CGFloat(heightDetents[1])
        currentWidth = CGFloat(widthDetents[1])
    }
    
    func body(content: Content) -> some View {
        let presentationStyle = PresentationStyle.choose(hSizeClass: hSizeClass, vSizeClass: vSizeClass)
        ZStack {
            content
            
            switch presentationStyle {
            case .bottomShelf:
                bottomShelf
            case .leftShelf:
                leftShelf
            case .fullScreen:
                fullScreen
            }
            
        }
        .zIndex(12)
        .animation(.spring(duration: 0.3), value: item != nil)
    }
    
    @ViewBuilder
    var bottomShelf: some View {
        if let item {
            ZStack(alignment: .top) {
                shelfContent(item)
                    .frame(maxWidth: .infinity)
                    .frame(height: currentHeight)
                
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
            .zIndex(12)
            .background(.yellow)
            .transition(.move(edge: .bottom))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    @ViewBuilder
    var leftShelf: some View {
        if let item {
            ZStack(alignment: .trailing) {
                shelfContent(item)
                    .frame(maxHeight: .infinity)
                    .frame(width: currentWidth)
                Capsule()
                    .fill(.secondary)
                    .frame(width: 36, height: 5)
                    .rotationEffect(Angle(degrees: 90))
                    .frame(maxHeight: .infinity)
                    .frame(width: 44)
                    
                    .background(.red)
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
            .background(.yellow)
            .transition(.move(edge: .leading))
            .zIndex(12)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }
    
    
    @ViewBuilder
    var fullScreen: some View {
        ZStack {
            if let item {
                shelfContent(item)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white)
                    .transition(.move(edge: .bottom))
                    .zIndex(12)
            }
        }
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
