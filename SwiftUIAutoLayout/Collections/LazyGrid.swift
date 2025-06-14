//
//  LazyGrid.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 11.06.2025.
//

import SwiftUI

struct LazyGrid: View {
    var body: some View {
        
        let columns: [GridItem] = [
            GridItem(.adaptive(minimum: 50, maximum: 300), spacing: nil, alignment: nil),
            
        ]
        
        
        ScrollView {
            LazyVGrid(
                columns: columns,
                pinnedViews: [.sectionHeaders]) {
                    Section(header: Text("Section 1")) {
                        ForEach(0..<20) { index in
                            Rectangle()
                                .frame(height: 50)
                        }
                    }
                    Section(header: Text("Section 2")) {
                        ForEach(0..<20) { index in
                            Rectangle()
                                .frame(height: 50)
                        }
                    }
                }
        }
    }
}

#Preview {
    LazyGrid()
}
