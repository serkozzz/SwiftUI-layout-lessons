//
//  CircleLayout.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 04.07.2025.
//

import SwiftUI



struct CircleLayoutExample: View {
    var body: some View {
        CircleLayout(radius: 80) {
            ForEach(0..<6, id: \.self) { i in
                Circle()
                    .fill(.orange)
                    .frame(width: 20, height: 20)
            }
        }
    }
}


struct CircleLayout: Layout {
    
    let radius: CGFloat
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let maxSize = getMaxSize(for: subviews)
        
        return CGSize(
            width: radius * 2 + maxSize.width,
            height: radius * 2 + maxSize.height
        )
    }
    
    private func getMaxSize(for subviews: Subviews) -> CGSize {
        subviews.reduce(.zero) { currentMaxSize, subview in
            let currentSize = subview.sizeThatFits(.unspecified)
            return CGSize(
                width: max(currentSize.width, currentMaxSize.width),
                height: max(currentSize.height, currentMaxSize.height)
            )
        }
    }
    
    
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let maxSize = getMaxSize(for: subviews)
        let proposal = ProposedViewSize(maxSize)
        for (index, subview) in subviews.enumerated() {
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            let origin = getPosition(
                forSubviewIndex: index,
                radius: radius,
                center: center,
                subviewsCount: subviews.count
            )
            subview.place(at: origin, proposal: proposal)
        }
    }
    
    //...
    
    private func getPosition(
        forSubviewIndex index: Int,
        radius: CGFloat,
        center: CGPoint,
        subviewsCount: Int
    ) -> CGPoint {
        let theta = (CGFloat.pi * 2 / CGFloat(subviewsCount)) * CGFloat(index)
        return CGPoint(
            x: center.x + radius * cos(theta),
            y: center.y + radius * sin(theta)
        )
    }
}

#Preview {
    CircleLayoutExample()
}
