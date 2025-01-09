//
//  AddForkReviewViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import Foundation
import RxCocoa

class AddForkReviewViewModel {
    var reviews: BehaviorRelay<String> = BehaviorRelay(value: "")
    var detailHeight: BehaviorRelay<Float> = BehaviorRelay(value: .zero)
}
