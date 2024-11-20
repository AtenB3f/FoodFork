//
//  AddForkSearchViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/03.
//

import Foundation
import RxSwift
import RxCocoa
import Domain
import Data

class AddForkSearchViewModel {
    var page: Int = 1

    var storeInfo = BehaviorRelay(value: [PlaceInfoModel]())

    func search(word: String, page: Int = 1) {

        APIServer().request(.kakaoSearchKeyword(token: KakaoManager.authKey,
                                                keyword: word,
                                                page: page), PlaceModel.self) { data in
            if let info = data?.documents {
                self.storeInfo.accept(self.page == page ? info : self.storeInfo.value + info)
            }
        }
    }
}
