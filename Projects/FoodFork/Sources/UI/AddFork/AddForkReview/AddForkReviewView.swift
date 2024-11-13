//
//  AddForkReviewView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit
import Design

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
        self.addSubview(scroll)
        scroll.addSubview(contents)
        contents.addSubview(guideText)
        contents.addSubview(input)
        contents.addSubview(divider)
        self.addSubview(button)
        
        header.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(header.height)
        }
        
        scroll.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.bottom.left.right.width.equalToSuperview()
        }
        
        contents.snp.makeConstraints {
            $0.center.width.height.equalToSuperview()
        }
        
        guideText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(58)
            $0.left.equalToSuperview().inset(16)
        }
        
        input.snp.makeConstraints {
            $0.top.equalTo(guideText.snp.bottom).offset(50)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        divider.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(2)
            $0.top.equalTo(input.snp.bottom).offset(1)
        }
        
        button.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setAttribute() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        self.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        button.enable()
    }
    
    func reloadView() {
        NotificationCenter.default.post(name: .reloadView, object: nil)
    }
    
    lazy var header = PrevHeaderView(title: "후기 입력(4/4)", callback: {
        self.navigation?.popNavigation(isRoot: false)
    })
    
    lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = true//false
        return scroll
    }()
    
    lazy var contents = UIView()
    
    lazy var guideText = ForkTextView(font: .fontHeader2, text: "선택하신 매장의\n음식은 어땠나요?")
    
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
    var parentViewModel: AddForkViewModel? {
        didSet {
            guideText.text = "\(parentViewModel?.fork.storeName ?? "")의\n음식은 어땠나요?"
        }
    }
    
    @objc func onClick() {
        parentViewModel?.setForkInfo(review: input.text)
        parentViewModel?.saveFork()
        self.navigation?.popNavigation(isRoot: true)
    }
    
    @objc func tapView() {
        print("tapView")
        self.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize.height)
            scroll.snp.remakeConstraints {
                $0.top.equalTo(header.snp.bottom)
                $0.left.right.width.equalToSuperview()
                $0.bottom.equalToSuperview().inset(keyboardSize.height)
            }
            contents.snp.remakeConstraints {
                $0.center.width.height.equalToSuperview()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scroll.snp.remakeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.bottom.left.right.width.equalToSuperview()
        }
        contents.snp.remakeConstraints {
            $0.center.width.height.equalToSuperview()
        }
    }
}
