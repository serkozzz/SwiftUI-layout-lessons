//
//  IndexCardsLayout.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 10.06.2025.
//

import SwiftUI


private class IndexCardsLayoutViewModel: ObservableObject {
    @Published var cards: [Int] = Array(0...11)
}



struct IndexCardsWithStack: View {
    
    @ObservedObject private var viewModel = IndexCardsLayoutViewModel()
    private var cellSize = CGSize(width: 250, height: 300)

    var body: some View {
        GeometryReader { geo in
            let columnsNumber = Int(geo.size.width / cellSize.width)
            ScrollView {
                VStack(spacing: 16) {
                    let groups = groupCards(itemsPerGroup: columnsNumber)
                    ForEach(groups, id: \.self) { group in
                        HStack(spacing: 8) {
                            ForEach(group, id: \.self) { item in
                                Cell(text: String(item))
                                    .frame(width: cellSize.width, height: cellSize.height)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                }
            }
        }
    }
    
    func groupCards(itemsPerGroup: Int) -> [[Int]] {
        let groupedCards = stride(from: 0, to: viewModel.cards.count, by: itemsPerGroup).map { index in
            Array(viewModel.cards[index..<min(index + itemsPerGroup, viewModel.cards.count)])
        }
        print (groupedCards)
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
    IndexCardsWithStack()
}
