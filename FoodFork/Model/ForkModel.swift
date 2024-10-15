//
//  ForkModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/03.
//

import Foundation
import RealmSwift
import UIKit

class ForkInfoObject: Object, Persistable {
    dynamic var name: String = ""
    dynamic var address: String = ""
    dynamic var rate: Double = .zero
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    required init(managedObject: ForkInfoObject) {
        name = managedObject.name
        address = managedObject.address
        rate = managedObject.rate
    }
    public func managedObject() -> ForkInfoObject {
        let info = ForkInfoObject()
        info.name = name
        info.address = address
        info.rate = rate
        return info
    }
}

struct ForkInfoModel {
    var pid: Int?
    var storeName: String?
    var address: String?
    var rate: Double?
    var review: String?
}

struct StoreInfoModel: Identifiable {
    let id = UUID()
    var storeName: String
    var address: String
    var lotNumber: String
}
