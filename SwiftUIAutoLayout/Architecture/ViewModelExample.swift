//
//  ViewModelExample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 31.07.2025.
//

import SwiftUI
import Combine

@MainActor
private class ViewModel: ObservableObject {
    @Published var owner: String?
    
    private var car: Car
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let cars = try! CoreDataStack.shared.managedContext.fetch(Car.fetchRequest())
        car = cars.first!
//        
//        car.publisher(for: \.ownerValue).sink { [unowned self] value  in
//            owner = value!
//        }.store(in: &cancellables)
        
        car.publisher(for: \.ownerValue).assign(to: &$owner)
    }
    
    func setOwner(newOwner: String) {
        car.owner = newOwner
    }
}


struct ViewModelExample : View {
    
    @StateObject private var viewModel = ViewModel()
   
    var body: some View {
        TextField("owner", text: Binding( get: {
            viewModel.owner!
        },
        set: { newValue in
            viewModel.setOwner(newOwner: newValue)
        }))
    }
}



