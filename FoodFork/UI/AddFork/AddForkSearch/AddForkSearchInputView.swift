//
//  AddForkSearchInputView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/02.
//

import UIKit

class AddForkSearchInputView: UIView, ViewLayout {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        addSubview(input)

        input.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(self.height)
            $0.center.equalToSuperview()
        }
    }

    func setAttribute() {
        input.backgroundColor = .white
    }

    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
        }
    }

    let height: CGFloat = 78

    lazy var input: UIButton = {
        let button = UIButton()

        let help: UILabel = {
            let help = UILabel()

            help.text = "찾으시는 매장이 없으신가요?"
            help.textColor = .Text.disable10
            help.font = .fontBody1

            return help
        }()

        let input: UILabel = {
            let input = UILabel()

            input.text = "주소 직접 입력하기"
            input.textColor = .Text.medium30
            input.font = .fontBody3

            return input
        }()

        let arrow = UIImageView(image: UIImage(named: "Arrow_Right")!)

        let divider = UIView()
        divider.backgroundColor = .Other.divider

        button.addSubview(help)
        button.addSubview(input)
        button.addSubview(arrow)
        button.addSubview(divider)

        help.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.equalToSuperview().inset(20)
        }

        input.snp.makeConstraints {
            $0.top.equalTo(help.snp.bottom).offset(12)
            $0.left.equalTo(help.snp.left)
        }

        arrow.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalTo(input.snp.centerY)
        }

        divider.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }

        button.addTarget(self, action: #selector(actionInput), for: .touchUpInside)

        return button
    }()

    @objc func actionInput() {
        navigation?.pushNavigation(target: .addFork)
    }
}
