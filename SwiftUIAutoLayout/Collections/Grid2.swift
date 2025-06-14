//
//  GridViewBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Nick Sarno on 1/27/24.
//

import SwiftUI

struct GridViewBootcamp: View {
    var body: some View {
        Grid(alignment: .center, horizontalSpacing: 8, verticalSpacing: 8) {
            ForEach(0..<4) { rowIndex in
                GridRow(alignment: .bottom) {
                    ForEach(0..<4) { columnIndex in
                        let cellNumber = (rowIndex * 4) + (columnIndex + 1)
                        cell(int: cellNumber)
                    }
                }
            }
        }
    }
    
    private func cell(int: Int) -> some View {
        Text("\(int)")
            //.frame(height: int == 10 ? 20 : nil)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
    }
}

#Preview {
    GridViewBootcamp()
}
