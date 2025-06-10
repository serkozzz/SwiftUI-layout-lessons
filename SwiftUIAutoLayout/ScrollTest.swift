//
//  ScrollText.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 10.06.2025.
//

import SwiftUI

struct IdealWidthExample: View {
    var body: some View {

        Rectangle()
        //.rotation(.degrees(45))
        .fill(Color.red)
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
        
//        .padding()
//        .background(Color.blue.opacity(0.1))
    }
}

#Preview {
    IdealWidthExample()
}
