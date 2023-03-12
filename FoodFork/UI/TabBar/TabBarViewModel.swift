//
//  TabBarViewModel.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/09.
//

import Foundation
import RxSwift
import RxCocoa

struct TabBarModel {
    var tab: TabBarType
}

class TabBarViewModel: ViewModelType {
    struct Input {
        var tab: Driver<TabBarType>
    }
    
    struct Output {
        let selectedTab: Driver<TabBarType>
    }
    
    var selectedTab = BehaviorRelay(value: TabBarType.fork)
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        input.tab.drive(onNext: { tab in
        }).disposed(by: disposeBag)
        
        return Output(selectedTab: input.tab)
    }
}
