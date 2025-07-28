//
//  Car+CoreDataClass.swift
//  CoreDataSandbox
//
//  Created by Sergey Kozlov on 27.07.2025.
//
//

import Foundation
import CoreData

@objc(Car)
public class Car: NSManagedObject {

    var speed: Int {
        get { Int(speedValue) }
        set { speedValue = Int32(newValue) }
    }
    var weight: Int {
        get { Int(weightValue) }
        set { weightValue = Int32(newValue) }
    }
    
    var owner: String {
        get { ownerValue! }
        set { ownerValue = newValue }
    }
}
