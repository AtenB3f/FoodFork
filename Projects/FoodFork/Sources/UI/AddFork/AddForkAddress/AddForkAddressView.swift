//
//  AddForkAddressView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit
import RxSwift
import Design

class AddForkAddressView: UIView, ViewLayout {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }
    
    func setLayout() {
        self.addSubview(header)
        self.addSubview(guideText)
        self.addSubview(input)
        self.addSubview(divider)
        self.addSubview(button)
        
        header.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(header.height)
        }
        
        guideText.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(58)
            $0.left.right.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        
        input.snp.makeConstraints {
            $0.top.equalTo(guideText.snp.bottom).offset(50)
            $0.left.right.equalToSuperview().inset(16)
            $0.width.centerX.equalToSuperview()
        }
        
        divider.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(2)
            $0.top.equalTo(input.snp.bottom)
        }
        
        button.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setAttribute() {
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    var viewModel: AddForkAddressViewModel?
    var parentViewModel: AddForkViewModel?
    
    lazy var header = PrevHeaderView(title: "주소 검색(1/4)", callback: {
        self.navigation?.popNavigation(isRoot: false)
    })
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.text = "주소를 입력해주세요."
        text.font = .fontHeader2
        text.textColor = .Text.medium30
        
        return text
    }()
    
    lazy var input = TextInputView(font: .fontSubtitle1,
                                        placeholder: "주소 입력...",
                                        onChange: { text in
        text.isEmpty ? self.button.disable() : self.button.enable()
    })
    
    lazy var divider = DividerView(color: .Brand.main30)
    
    lazy var button = RoundSquareButton(text: "다음",
                                        onKeyboard: true)
    
    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
        }
    }
    
    @objc func onClick() {
        parentViewModel?.setForkInfo(address: input.text)
        self.navigation?.pushNavigation(target: .addForkPicture(parentViewModel: parentViewModel ?? AddForkViewModel()))
    }
}

