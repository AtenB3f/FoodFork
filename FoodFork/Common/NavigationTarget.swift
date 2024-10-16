//
//  NavigationTarget.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/29.
//

import Foundation

enum NavigationTarget {
    case root
    case addFork
    case test
    case addForkSearch(parentViewModel: AddForkViewModel)
    case addForkInputAddress(parentViewModel: AddForkViewModel)
    case addForkPicture(parentViewModel: AddForkViewModel)
    case addForkStar(parentViewModel: AddForkViewModel)
    case addForkReview(parentViewModel: AddForkViewModel)
    
}
