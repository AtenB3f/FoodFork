//
//  ForkTextView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/20/24.
//


import UIKit

class ForkTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(frame: CGRect = .zero,
                     textContainer: NSTextContainer? = nil,
                     color: UIColor = .Text.medium30,
                     font: UIFont = .fontBody2,
                     text: String? = nil
    ) {
        self.init(frame: frame, textContainer: textContainer)
        
        self.textColor = color
        self.font = font
        self.text = text
        self.textAlignment = .left
        self.isEditable = false
        self.isScrollEnabled = false
        self.backgroundColor = .clear
    }
    
    func setText(_ text: String) {
        self.text = text
//        layoutIfNeeded()
        self.frame.size = self.textContainer.size
    }
}
