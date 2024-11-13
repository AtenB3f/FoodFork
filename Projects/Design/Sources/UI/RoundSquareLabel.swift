//
//  RoundSquareLabel.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/22/24.
//

import UIKit

public class RoundSquareLabel: UILabel {
    private var padding = UIEdgeInsets(top: 2.0, left: 8.0, bottom: 2.0, right: 8.0)
       
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
   
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
   
    public override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
    
    public convenience init(frame: CGRect = .zero,
                     text: String = "",
                     font: UIFont = .fontBody2,
                     textColor: UIColor = .Text.light20,
                     backgroundColor: UIColor = .Gray.disable10) {
        self.init(frame: frame)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
}
