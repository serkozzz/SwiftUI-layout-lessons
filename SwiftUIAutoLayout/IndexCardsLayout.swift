//
//  IndexCardsLayout.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 10.06.2025.
//

import SwiftUI


class IndexCardsLayoutViewModel: ObservableObject {
    @Published var cards: [Int] = Array(0...10)
}



struct TilesWithStack: View {
    
    @ObservedObject var viewModel = IndexCardsLayoutViewModel()
    @State var itemsPerGroup = 3

    var body: some View {
        GeometryReader { geo in
            let cellWidth = geo.size.width / CGFloat(itemsPerGroup)
            ScrollView {
                VStack(spacing: 16) {
                    
                    let groups = groupCards(itemsPerGroup: itemsPerGroup)
                    ForEach(groups, id: \.self) { group in
                        HStack(spacing: 8) {
                                                    
                            ForEach(group, id: \.self) { item in
    
                                Cell(text: String(item))
                                    .frame(width: cellWidth)
                            }
                            //.frame(width: geo.size.width / 2)

                       }
                        .frame(height: geo.size.height / 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
    
    func groupCards(itemsPerGroup: Int) -> [[Int]] {
        let groupedCards = stride(from: 0, to: viewModel.cards.count, by: itemsPerGroup).map { index in
            Array(viewModel.cards[index..<min(index + itemsPerGroup, viewModel.cards.count)])
        }
        return groupedCards
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
    TilesWithStack()
}
