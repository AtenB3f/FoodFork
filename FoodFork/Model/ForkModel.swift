//
//  ForkModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/03.
//

import Foundation
import RealmSwift
import UIKit
import KakaoMapsSDK

class ForkInfoObject: Object {
    @Persisted var uuid: String = ""
    @Persisted var storeName: String = ""
    @Persisted var category: String = ""
    @Persisted var address: String = ""
    @Persisted var x: String = ""
    @Persisted var y: String = ""
    @Persisted var rate: Double = .zero
    @Persisted var review: String = ""
    @Persisted var pictureCount: Int = 0
    
    required override init() {
        
    }
    
    init(model: ForkInfoModel) {
        super.init()
        
        uuid = model.uuid?.uuidString ?? ""
        storeName = model.storeName ?? ""
        category = model.category ?? ""
        x = model.x ?? ""
        y = model.y ?? ""
        address = model.address ?? ""
        rate = model.rate ?? .zero
        review = model.review ?? ""
        pictureCount = model.pictures?.count ?? 0
    }
    
    public func toModel() -> ForkInfoModel {
        var info = ForkInfoModel()
        info.uuid = UUID(uuidString: uuid)
        info.storeName = storeName
        info.category = category
        info.x = x
        info.y = y
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
    var x: String?
    var y: String?
    var category: String?
    var pictures: [UIImage]?
    
    func getMapPoint() -> MapPoint? {
        guard let x, let y else { return nil }
        guard let longitude = Double(x), let latitude = Double(y) else { return nil }
        return MapPoint(longitude: longitude, latitude: latitude)
    }
    
    func getPoint() -> ForkPoint? {
        guard let x, let y else { return nil }
        guard let longitude = Double(x), let latitude = Double(y) else { return nil }
        return ForkPoint(x: longitude, y: latitude)
    }
}

