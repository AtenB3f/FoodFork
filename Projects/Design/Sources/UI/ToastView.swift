//
//  ToastView.swift
//  Design
//
//  Created by Ivy Moon on 1/13/25.
//
import UIKit

public func showToast(_ view: UIView,
                      message: String,
                      duration: TimeInterval = 2.0) {
    let toastLabel = UILabel()
    toastLabel.font = .fontBody2
    toastLabel.backgroundColor = .Text.dark40
    toastLabel.textColor = .white
    toastLabel.textAlignment = NSTextAlignment.center
    toastLabel.text = message
    toastLabel.alpha = 0.7
    toastLabel.layer.cornerRadius = 5
    toastLabel.clipsToBounds  =  true
    let rect = CGRect(x: 16,
                      y: view.frame.size.height-100,
                      width: view.frame.size.width-32,
                      height: 40)
    toastLabel.frame = rect
    view.addSubview(toastLabel)
    UIView.animate(withDuration: 0.4,
                   delay: duration - 0.4,
                   options: UIView.AnimationOptions.curveEaseOut,
                   animations: {
                                    toastLabel.alpha = 0.0
                                },
                   completion: { (_) in
                                    toastLabel.removeFromSuperview()
                                })
}
