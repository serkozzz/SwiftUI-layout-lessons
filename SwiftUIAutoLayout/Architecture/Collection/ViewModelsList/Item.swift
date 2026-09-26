//
//  Item.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 25.09.2026.
//

import SwiftUI
import Combine

extension ViewModelsListExample {
    
    class Item: Equatable {
        var id: Int
        var name: String {
            didSet {
                nameSubject.send(name)
            }
        }
        
        private let nameSubject: CurrentValueSubject<String, Never>
        var namePublisher: AnyPublisher<String, Never> { nameSubject.eraseToAnyPublisher() }
        
        init(id: Int, name: String) {
            self.id = id
            self.name = name
            nameSubject = CurrentValueSubject(self.name)
        }
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            lhs.id == rhs.id
        }
    }
}
