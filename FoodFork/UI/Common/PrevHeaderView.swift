//
//  PrevHeaderView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/01.
//

import UIKit

class PrevHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(frame: CGRect = .zero,
                     title: String = "",
                     callback: @escaping ()->Void,
                     contents: UIView = UIView(),
                     backgroundColor: UIColor = .Base.light20) {
        self.init(frame: frame)
        self.callback = callback
        self.contents = contents
        
        setLayout()
        setAttribute(title: title, backgroundColor: backgroundColor)
    }
    
    let height: CGFloat = 60
    
    var callback: (()->Void)? = nil
    
    private lazy var header = UIView()
    
    private lazy var prev:UIButton =  {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Prev_Arrow")!, for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var label = UILabel()
    
    private lazy var contents = UIView()
    
    func setLayout() {
        self.addSubview(header)
        header.addSubview(prev)
        header.addSubview(label)
        header.addSubview(contents)
        
        header.snp.makeConstraints {
            $0.height.equalTo(height)
            $0.width.equalTo(self.snp.width)
            $0.top.equalToSuperview()
        }
        
        prev.snp.makeConstraints {
            $0.left.equalToSuperview().inset(6)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        contents.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setAttribute(title: String, backgroundColor: UIColor) {
        header.backgroundColor = backgroundColor
        
        label.font = .fontSubtitleBold1
        label.textColor = .Text.medium30
        label.text = title
    }
    
    @objc func handleTap() {
        print("handle")
        callback?()
    }
}
