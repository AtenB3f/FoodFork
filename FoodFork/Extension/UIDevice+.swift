//
//  UIDevice+.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/09.
//

import UIKit

extension UIDevice {
    // 노치 바텀 높이
    var notchHeightBottom: CGFloat {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        return window?.safeAreaInsets.bottom ?? 0
    }
    
    // 노치 탑 높이
    var notchHeightTop: CGFloat {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        return window?.windowScene?.keyWindow?.safeAreaInsets.top ?? 0
    }
}
