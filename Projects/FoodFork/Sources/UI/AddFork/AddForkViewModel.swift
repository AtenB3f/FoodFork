//
//  AddForkViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/8/24.
//
import Data

public class AddForkViewModel {
    
    var fork = ForkInfoModel()
    
    // AddFork View에서 얻는 데이터 하나씩 저장하기
    func setForkInfo(storeName: String? = nil,
                     category: String? = nil,
                     x: String? = nil,
                     y: String? = nil,
                     address: String? = nil,
                     rate: Double? = nil,
                     review: String? = nil
    ) {
        if let storeName = storeName { fork.storeName = storeName }
        if let category = category { fork.category = category }
        if let address = address { fork.address = address }
        if let x = x { fork.x = x }
        if let y = y { fork.y = y }
        if let rate = rate { fork.rate = rate }
        if let review = review { fork.review = review }
    }
    
    // AddForkReview View에서 저장할 때 Realm 이용하여 저장
    func saveFork() {
        let object = ForkInfoObject(model: fork)
        
        RealmManager.shared.add(object)
    }
    
    
}
