//
//  TabBarEnum.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit

enum TabBarType: Int {
    case fork
    case plate
//    case my

    var icon: UIImage {
        get {
            switch self {
            case .fork:
                return UIImage(named: "Fork_On")!
            case .plate:
                return UIImage(named: "Plate_On")!
//            case .my:
//                return UIImage(named: "Star_On")!
            }
        }
    }

    func icon(_ isSelect: Bool) -> UIImage {
        switch self {
        case .fork:
            return UIImage(named: "Fork_\(isSelect ? "On" : "Off")")!
        case .plate:
            return UIImage(named: "Plate_\(isSelect ? "On" : "Off")")!
//        case .my:
//            return UIImage(named: "Star_\(isSelect ? "On" : "Off")")!
        }
    }

    var viewController: UIViewController {
        switch self {
        case .fork:
            return ForkViewController()
        case .plate:
            return PlateViewController()
//        case .my:
//            return ForkViewController()
        }
    }
}
