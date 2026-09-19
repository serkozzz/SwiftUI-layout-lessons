//
//  CustomSheetModifier.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 20.09.2026.
//

import SwiftUI

struct CustomSheetModifier<Item: Identifiable, SheetContent: View>: ViewModifier {
    
    enum PresentationStyle {
        case bottomSheet
        case centeredModal
        case fullScreen
        
        static func choose(hSizeClass: UserInterfaceSizeClass?,
                                            vSizeClass: UserInterfaceSizeClass?) ->PresentationStyle {
            if vSizeClass == .compact {
                return .fullScreen
            }
            if hSizeClass == .compact {
                return .bottomSheet
            }
            return .centeredModal
        }
    }
    
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    
    @Binding var item: Item?
    let sheetContent: (Item) -> SheetContent
    
    func body(content: Content) -> some View {
        let presentationStyle = PresentationStyle.choose(hSizeClass: hSizeClass, vSizeClass: vSizeClass)
        ZStack {
            content
            
            switch presentationStyle {
            case .bottomSheet:
                bottomSheet
            case .centeredModal:
                centerModal
            case .fullScreen:
                fullScreen
            }
            
        }
        .animation(.spring(duration: 0.3), value: item != nil)
    }
    
    @ViewBuilder
    var bottomSheet: some View {
        ZStack(alignment: .bottom) {
            if let item {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        self.item = nil
                    }
                    .zIndex(11)
                sheetContent(item)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .background(.white)
                    .transition(.move(edge: .bottom))
                    .zIndex(12)
            }
        }
    }
    
    @ViewBuilder
    var fullScreen: some View {
        ZStack {
            if let item {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        self.item = nil
                    }
                    .zIndex(11)
                sheetContent(item)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white)
                    .transition(.move(edge: .bottom))
                    .zIndex(12)
            }
        }
    }
    
    @ViewBuilder
    var centerModal: some View {
        ZStack {
            if let item {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        self.item = nil
                    }
                    .zIndex(11)
                sheetContent(item)
                    .frame(width: 350, height: 250)
                    .background(.white)
                    .transition(.move(edge: .bottom))
                    .zIndex(12)
            }
        }
    }
    
}


extension View {
    func customSheet<Item: Identifiable, SheetContent: View>(
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> SheetContent
    ) -> some View {
        modifier(CustomSheetModifier(item: item, sheetContent: content))
    }
}
