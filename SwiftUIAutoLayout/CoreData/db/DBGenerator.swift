//
//  DBGenerator.swift
//  CoreDataSandbox
//
//  Created by Sergey Kozlov on 27.07.2025.
//


import CoreData

@MainActor
class DBGenerator {
    func generateIfNeeded() {
        
        let fetchRequest = Car.fetchRequest()
        let count = try? CoreDataStack.shared.managedContext.count(for: fetchRequest)
        
        guard let cellsCount = count, cellsCount == 0 else { return }
        
        generate()
    }
    
    private func generate() {
        let context = CoreDataStack.shared.managedContext
        
        let car = Car(context: context)
        car.speed = 60
        car.weight = 2000
        car.owner = "Kozlov"
        try! context.obtainPermanentIDs(for: [car])
        try! context.save()
    }
}
