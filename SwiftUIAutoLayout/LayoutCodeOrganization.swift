//
//  LayoutCodeOrganization.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 15.06.2025.
//
import SwiftUI


//MARK: View extention
extension View {
    func circle(foreground: Color = .white, background: Color = .blue) -> some View {
        Circle()
            .fill(background)
            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(self.foregroundColor(foreground))
            .frame(width: 75, height: 75)
    }
}


//MARK: Container with ViewBuilder
struct CircleWrapper<Content: View>: View {
    var foreground, background: Color
    var content: Content
    init(foreground: Color = .white, background: Color = .blue, @ViewBuilder content: () -> Content) {
        self.foreground = foreground
        self.background = background
        self.content = content()
    }
    var body: some View {
        Circle()
            .fill(background)
            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(content.foregroundColor(foreground))
            .frame(width: 75, height: 75)
    }
}



//MARK: ViewModifier
struct CircleModifier: ViewModifier {
    var foreground: Color = .white
    var background: Color = .blue
    func body(content: Content) -> some View {
        Circle()
            .fill(background)
            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(content.foregroundColor(foreground))
            .frame(width: 75, height: 75)
    }
}

#Preview {
    
    Text("Hello")
        .circle(foreground: .white, background: .blue)
    
    CircleWrapper {
        Text("Hello")
    }
    
    Text("Hello")
        .modifier(CircleModifier())
}
