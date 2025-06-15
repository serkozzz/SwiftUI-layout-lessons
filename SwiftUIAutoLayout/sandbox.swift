//
//  sandbox.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 14.06.2025.
//

import SwiftUI


struct sandbox: View {

    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Rectangle().fill(.red)
                .frame(width: 200, height: 100)
            
            Rectangle().fill(.green)
                .frame(width: 50, height: 50)
                .alignmentGuide(.top) { dimension in
                    60
            }
        }
    }
}

#Preview {
    sandbox()
}
