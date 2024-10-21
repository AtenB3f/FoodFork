//
//  AddForkReviewView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit

class AddForkReviewView: UIView, ViewLayout {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }
    
    var viewController: UIViewController?
    
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
        button.enable()
    }
    
    func reloadView() {
        NotificationCenter.default.post(name: .reloadView, object: nil)
    }
    
    lazy var header = PrevHeaderView(title: "후기 입력(4/4)", callback: {
        self.navigation?.popNavigation(isRoot: false)
    })
    
    lazy var guideText: UILabel = {
        let text = UILabel()
        text.text = "선택하신 매장의\n음식은 어땠나요?"
        text.font = .fontHeader2
        text.textColor = .Text.medium30
        
        return text
    }()
    
    lazy var input = TextInputView(font: .fontSubtitle1,
                                        placeholder: "음식, 서비스, 매장 분위기 등\n솔직한 내용을 자유롭게 작성해주세요!",
                                        onChange: { text in
        self.button.setTitle(text.isEmpty ? "생략하기" : "완료", for: .normal)
    })
    
    lazy var divider = DividerView(color: .Brand.main30)
    
    lazy var button = RoundSquareButton(text: "생략하기",
                                        onKeyboard: true)
    
    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
        }
    }
    
    var viewModel: AddForkReviewViewModel?
    var parentViewModel: AddForkViewModel?
    
    @objc func onClick() {
        parentViewModel?.setForkInfo(review: input.text)
        parentViewModel?.saveFork()
        self.navigation?.popNavigation(isRoot: true)
    }
}
