//
//  ContentView.swift
//  CoreDataSandbox
//
//  Created by Sergey Kozlov on 27.07.2025.
//

import SwiftUI

struct FetchRequestExample: View {
    
    @FetchRequest(entity: Car.entity(), sortDescriptors: [])
    var cars: FetchedResults<Car>
    
    var body: some View {
        let car = cars.first!
        Text("Car speed: \(car.speed)")
        
        Button("speed +") {
            car.speed += 1
        }
    }
}



//struct ContentView: View {
//    @StateObject var viewModel = ViewModel()
//
//    var body: some View {
//        VStack {
//
//            Text("Car speed: \(viewModel.carSpeed)")
//            Text("Car weight: \(viewModel.carWeight)")
//            Button("speed +") {
//                viewModel.setSpeed(newValue: viewModel.carSpeed + 1)
//            }
//            Button("weight +") {
//                viewModel.setWeight(newValue: viewModel.carWeight + 1)
//            }
//        }
//        .padding()
//    }
//}

#Preview {
    FetchRequestExample()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedContext)
}
