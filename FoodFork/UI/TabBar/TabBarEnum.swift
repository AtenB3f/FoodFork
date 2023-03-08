//
//  TabBarEnum.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit

enum TabBarType {
    case fork
    case plate
    case my
    
    var icon: UIImage {
        get {
            switch self {
            case .fork:
                return UIImage(named: "Star_On")!
            case .plate:
                return UIImage(named: "Star_On")!
            case .my:
                return UIImage(named: "Star_On")!
            }
        }
    }
    
    func icon(_ isSelect: Bool) -> UIImage {
        switch self {
        case .fork:
            return UIImage(named: "Star_\(isSelect ? "On" : "Off")")!
        case .plate:
            return UIImage(named: "Star_\(isSelect ? "On" : "Off")")!
        case .my:
            return UIImage(named: "Star_\(isSelect ? "On" : "Off")")!
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .fork:
            return ForkViewController()
        case .plate:
            return ForkViewController()
        case .my:
            return ForkViewController()
        }
    }
}
