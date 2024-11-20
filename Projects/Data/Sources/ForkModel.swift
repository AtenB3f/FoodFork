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

public class ForkInfoObject: Object {
    @Persisted public var uuid: String = ""
    @Persisted public var storeName: String = ""
    @Persisted public var category: String = ""
    @Persisted public var address: String = ""
    @Persisted public var xPoint: String = ""
    @Persisted public var yPoint: String = ""
    @Persisted public var rate: Double = .zero
    @Persisted public var review: String = ""
    @Persisted public var pictureCount: Int = 0
    
    required override init() {
        
    }
    
    public init(model: ForkInfoModel) {
        super.init()
        
        uuid = model.uuid?.uuidString ?? ""
        storeName = model.storeName ?? ""
        category = model.category ?? ""
        xPoint = model.xPoint ?? ""
        yPoint = model.yPoint ?? ""
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
        info.xPoint = xPoint
        info.yPoint = yPoint
        info.address = address
        info.rate = rate
        info.review = review
        if let uuid = info.uuid , !storeName.isEmpty {
            info.pictures = SaveFileManager().loadAllImageFromDocumentDirectory(imageName: storeName.isEmpty ? uuid.uuidString : storeName, count: pictureCount)
        }
        
        return info
    }
}

public struct ForkInfoModel {
    public init(uuid: UUID? = UUID(),
                storeName: String? = nil,
                address: String? = nil,
                rate: Double? = nil,
                review: String? = nil,
                x: String? = nil,
                y: String? = nil,
                category: String? = nil,
                pictures: [UIImage]? = nil) {
        self.uuid = uuid
        self.storeName = storeName
        self.address = address
        self.rate = rate
        self.review = review
        self.xPoint = x
        self.yPoint = y
        self.category = category
        self.pictures = pictures
    }
    public var uuid: UUID? = UUID()
    public var storeName: String?
    public var address: String?
    public var rate: Double?
    public var review: String?
    public var xPoint: String?
    public var yPoint: String?
    public var category: String?
    public var pictures: [UIImage]?
    
    public func getMapPoint() -> MapPoint? {
        guard let xPoint, let yPoint else { return nil }
        guard let longitude = Double(xPoint), let latitude = Double(yPoint) else { return nil }
        return MapPoint(longitude: longitude, latitude: latitude)
    }
    
    public func getPoint() -> ForkPoint? {
        guard let xPoint, let yPoint else { return nil }
        guard let longitude = Double(xPoint), let latitude = Double(yPoint) else { return nil }
        return ForkPoint(x: longitude, y: latitude)
    }
}

public struct ForkPoint {
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    public var x: Double
    public var y: Double
}
