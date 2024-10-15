//
//  RealmProtocol.swift
//  FoodFork
//
//  Created by Ivy Moon on 9/30/24.
//

import Foundation
import RealmSwift

public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

