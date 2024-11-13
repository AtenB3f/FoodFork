//
//  MultiTextInputView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit

public class TextInputView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var color: UIColor = .Text.medium30
    var placeholder:String = ""
    var placeholderColor: UIColor = .Text.disable10
    var begin: (()->Void)? = nil
    var end: (()->Void)? = nil
    var onChange: ((String)->Void)? = nil
    
    var place: UILabel = UILabel()
    public convenience init(frame: CGRect = .zero,
                     textContainer: NSTextContainer? = nil,
                     color: UIColor = .Text.medium30,
                     font: UIFont = .fontBody2,
                     text: String? = nil,
                     placeholder: String = "",
                     placeholderColor: UIColor = .Text.disable10,
                     isMultiLine: Bool = true,
                     begin: (()->Void)? = nil,
                     end: (()->Void)? = nil,
                     onChange: ((String)->Void)? = nil
    ) {
        self.init(frame: frame, textContainer: textContainer)
        
        self.color = color
        self.textColor = color
        self.font = font
        self.text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        self.begin = begin
        self.end = end
        self.onChange = onChange
        
        self.place = {
            let label = UILabel()
            label.text = placeholder
            label.textColor = placeholderColor
            label.font = font
            
            self.addSubview(label)
            label.snp.makeConstraints {
                $0.top.height.equalToSuperview()
                $0.left.right.equalToSuperview().inset(6)
            }
            
            return label
        }()
        place.isHidden = text?.isEmpty ?? false
        
        self.delegate = self
        self.isEditable = true
        self.isScrollEnabled = !isMultiLine
    }
    
}

extension TextInputView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        if !placeholder.isEmpty {
            place.isHidden = !textView.text.isEmpty
        }
        self.onChange?(textView.text)
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        self.begin?()
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        self.end?()
    }
}
