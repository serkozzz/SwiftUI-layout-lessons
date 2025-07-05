//
//  SwiftUIView.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 05.07.2025.
//

import SwiftUI

struct MyHStackExample: View {

    var body: some View {
        MyHStack{
            Text("adf")
            Text("asetweqt")
            Rectangle().frame(width: 100, height: 50)
        }
        .background(.green)
    }
}

struct MyHStack: Layout {
    var spacing: CGFloat = 100
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        
        var containerWidth: CGFloat = 0
        var containerHeght: CGFloat = 0
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            containerWidth += size.width + spacing
            containerHeght = max(containerHeght, size.height)
        }
        containerWidth -= spacing
        return CGSize(width: containerWidth, height: containerHeght)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        
        var offset: CGFloat = 0
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            subview.place(at: CGPoint(x: bounds.minX + offset,
                                      y: bounds.midY - size.height / 2), proposal: proposal)
            
            
            
            offset += size.width + spacing
        }
    }
    
}



#Preview {
    MyHStackExample()
}
