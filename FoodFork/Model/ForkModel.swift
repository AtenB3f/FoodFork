//
//  ForkModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/03.
//

import Foundation
import RealmSwift
import UIKit

class ForkInfoObject: Object {
    @Persisted var uuid: String = ""
    @Persisted var storeName: String = ""
    @Persisted var address: String = ""
    @Persisted var rate: Double = .zero
    @Persisted var review: String = ""
    @Persisted var pictureCount: Int = 0
    
    required override init() {
        
    }
    
    init(model: ForkInfoModel) {
        super.init()
        
        uuid = model.uuid?.uuidString ?? ""
        storeName = model.storeName ?? ""
        address = model.address ?? ""
        rate = model.rate ?? .zero
        review = model.review ?? ""
        pictureCount = model.pictures?.count ?? 0
    }
    
    public func toModel() -> ForkInfoModel {
        var info = ForkInfoModel()
        info.uuid = UUID(uuidString: uuid)
        info.storeName = storeName
        info.address = address
        info.rate = rate
        info.review = review
        if let uuid = info.uuid , !storeName.isEmpty {
            info.pictures = SaveFileManager().loadAllImageFromDocumentDirectory(imageName: storeName.isEmpty ? uuid.uuidString : storeName, count: pictureCount)
        }
        
        return info
    }
}

struct ForkInfoModel {
    var uuid: UUID? = UUID()
    var storeName: String?
    var address: String?
    var rate: Double?
    var review: String?
    var pictures: [UIImage]?
}

struct StoreInfoModel: Identifiable {
    let id = UUID()
    var storeName: String
    var address: String
    var lotNumber: String
}
