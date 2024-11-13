//
//  ForkTextView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/20/24.
//


import UIKit

public class ForkTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public convenience init(frame: CGRect = .zero,
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
        self.textContainer.lineBreakMode = .byWordWrapping
        self.textContainerInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public var height: CGFloat {
        get {
            return self.textContainer.size.height
        }
    }
    
    public func setText(_ text: String) {
        self.text = text
        self.frame.size = self.textContainer.size
    }
}
