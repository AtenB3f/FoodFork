//
//  PlaceModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/18/24.
//

import Foundation

public struct PlaceModel: Codable {
    public var meta: MetaModel?
    public var documents: [PlaceInfoModel]?
    
    public struct MetaModel: Codable {
        public var totalCount: Int?
        
        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
        }
    }
}

public struct PlaceInfoModel: Codable {
    public var id: String?
    public var address: String?
    public var category: String?
    public var placeName: String?
    public var x: String?
    public var y: String?
    
    enum CodingKeys: String, CodingKey {
        case address = "road_address_name"
        case category = "category_name"
        case placeName = "place_name"
        case id, x, y
    }
}
