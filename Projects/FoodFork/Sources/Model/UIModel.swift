//
//  UIModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/21/24.
//

import Design
import UIKit
import RxSwift

struct CollectionData {
    let image: UIImage
}

struct CollectionDataSection {
    var items: [CollectionData]
}

//extension CollectionDataSection: SectionModelType {
//    typealias Item = CollectionData
//    
//    init(original: CollectionDataSection, items: [CollectionData]) {
//        self = original
//        self.items = items
//    }
//}
