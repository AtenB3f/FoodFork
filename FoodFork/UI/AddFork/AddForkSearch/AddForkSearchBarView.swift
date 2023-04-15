//
//  AddForkSearchBarView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/02.
//

import UIKit

class AddForkSearchBarView: UIView, ViewLayout {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        addSubview(textField)

        textField.snp.makeConstraints {
            $0.width.equalToSuperview().inset(16)
            $0.height.equalTo(44)
            $0.center.equalToSuperview()
        }
    }

    func setAttribute() {
        self.backgroundColor = .Base.medium30
    }

    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
        }
    }

    let height: CGFloat = 64

    lazy var textField: UITextField = {
        let textField = UITextField()

        textField.font = .fontBody2
        textField.textColor = .Text.medium30
        textField.backgroundColor = .white
        textField.clipsToBounds = true

        let close = UIButton()
        close.setImage(UIImage(named: "Close_Circle")!, for: .normal)
        close.addTarget(self, action: #selector(actionClose), for: .touchUpInside)

        close.snp.makeConstraints {
            $0.width.height.equalTo(34)
        }

        textField.rightView?.snp.makeConstraints {
            $0.width.height.equalTo(34)
        }
        textField.attributedPlaceholder = NSAttributedString(string: "상호명을 검색하세요",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.Gray.medium30])
        textField.rightView = close
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.Other.divider.cgColor

        return textField
    }()

    @objc func actionClose() {
        textField.text = ""
    }
}
