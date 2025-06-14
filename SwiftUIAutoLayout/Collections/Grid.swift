//
//  Grid.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 11.06.2025.
//
import SwiftUI

struct GridLesson: View {
    
    let items = Array(0..<50)
    var body: some View {
        ScrollView {
            Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 10) {
                
                ForEach(items, id: \.self) { item in
                    GridRow {
                        Text(String(item))
                            .font(.largeTitle)
                            
                            //.frame(width: 100, height: 100)
                            .background(Color.blue.opacity(0.1))
                        Text(String(item))
                            .font(.largeTitle)
                            //.frame(width: 100, height: 100)
                            .background(Color.blue.opacity(0.1))
                    }

                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}


#Preview {
    GridLesson()
}
