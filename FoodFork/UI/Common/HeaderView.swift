//
//  HeaderView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/12.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(frame: CGRect = .zero,
                     title: String = "",
                     contents: UIView = UIView(),
                     backgroundColor: UIColor = .white) {
        self.init(frame: frame)
        
        self.contents = contents
        
        setLayout()
        setAttribute(title: title, backgroundColor: backgroundColor)
    }
    
    let height: CGFloat = 60
    
    private lazy var header = UIView()
    
    private lazy var label = UILabel()
    
    private lazy var contents = UIView()
    
    func setLayout() {
        self.addSubview(header)
        header.addSubview(label)
        header.addSubview(contents)
        
        header.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(self.snp.width)
            make.top.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        contents.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func setAttribute(title: String, backgroundColor: UIColor) {
        header.backgroundColor = backgroundColor
        
        label.font = .fontSubtitleBold1
        label.textColor = .Text.medium30
        label.text = title
    }
}
