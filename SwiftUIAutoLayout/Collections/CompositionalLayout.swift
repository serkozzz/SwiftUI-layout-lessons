//
//  CompositionalLayout.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 10.06.2025.
//

import SwiftUI

private struct GroupData: Identifiable {
    let id = UUID()
    let items = Array(0..<5)
}

struct CompositionalLayout: View {
    
    private let groups: [GroupData] = [GroupData(), GroupData(), GroupData()]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(groups) { group in
                        HStack(spacing: 8) {
                            Cell(text: String(group.items[0]))
                                .frame(width: geo.size.width / 2)
                            VStack() {
                                Cell(text: String(group.items[1]))
                                Cell(text: String(group.items[2]))
                            }
                            VStack() {
                                Cell(text: String(group.items[3]))
                                Cell(text: String(group.items[4]))
                            }
                        }
                        .frame(height: geo.size.height / 2)
                    }
                }
            }
        }
    }
}

private struct Cell: View {
    let text: String
    var body: some View {
        Text(String(text))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue.opacity(0.1))
    }
}


#Preview {
    CompositionalLayout()
}
