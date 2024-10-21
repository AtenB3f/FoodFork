//
//  UIProtocol.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/21/24.
//

import Foundation

public protocol SectionModelType {
    associatedtype Item
    
    var items: [Item] { get }
    
    init(original: Self, items: [Item])
}
