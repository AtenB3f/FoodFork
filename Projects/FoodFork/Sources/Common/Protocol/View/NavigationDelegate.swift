//
//  NavigationDelegate.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/29.
//

import Foundation

protocol NavigationDelegate: AnyObject {
    func pushNavigation(target: NavigationTarget)

    func popNavigation(isRoot: Bool)
    
    func popNavigation(isLastNode: Bool)
}
