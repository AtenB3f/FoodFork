//
//  PlaceModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/18/24.
//

import Foundation

struct PlaceModel: Codable {
    var meta: MetaModel?
    var documents: [PlaceInfoModel]?
    
    struct MetaModel: Codable {
        var totalCount: Int?
        
        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
        }
    }
}

struct PlaceInfoModel: Codable {
    var id: String?
    var address: String?
    var category: String?
    var placeName: String?
    var x: String?
    var y: String?
    
    enum CodingKeys: String, CodingKey {
        case address = "road_address_name"
        case category = "category_name"
        case placeName = "place_name"
        case id, x, y
    }
}
