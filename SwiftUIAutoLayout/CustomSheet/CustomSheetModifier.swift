//
//  CustomSheetModifier.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 20.09.2026.
//

import SwiftUI

struct CustomSheetModifier<Item: Identifiable, SheetContent: View>: ViewModifier {
    @Binding var item: Item?
    let sheetContent: (Item) -> SheetContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
            ZStack(alignment: .bottom) {
                if let item {
                    Color.black.opacity(0.35)
                        .ignoresSafeArea()
                        //.transition(.opacity)
                        .onTapGesture {
                            self.item = nil
                        }
                        .zIndex(11)
                    sheetContent(item)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .background(.white)
                        .presentationDetents([.medium])
                        .transition(.move(edge: .bottom))
                        .zIndex(12)
                }
            }
            
        }
        .animation(.spring(duration: 0.3), value: item != nil)
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
