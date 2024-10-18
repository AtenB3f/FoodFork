//
//  AddForkSearchViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/03.
//

import Foundation

class AddForkSearchViewModel {
    var page: Int = 1
    var storeInfo: [PlaceInfoModel] = []
    
    func search(word: String) {
        APIServer().request(.kakaoSearchKeyword(keyword: word, page: page), PlaceModel.self) { data in
            if let info = data?.documents {
                self.storeInfo = info
            }
        }
    }
}
