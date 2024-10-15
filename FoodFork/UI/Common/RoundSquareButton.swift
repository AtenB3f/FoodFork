//
//  RoundSquareButton.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/7/24.
//

import UIKit
import RxSwift

class RoundSquareButton: UIButton {
    private let disposeBag = DisposeBag()
    
    private var isEnable: Bool = false
    private var enableColor: UIColor = .Brand.main30
    private var disableColor: UIColor = .Gray.medium30
    private var font: UIFont = .fontBody2
    var text: String = ""
    private var textEnableColor: UIColor = .white
    private var textDisableColor: UIColor = .Text.disable10
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect = .zero,
                     enableColor: UIColor = .Brand.main30,
                     disableColor: UIColor =  .Gray.medium30,
                     font: UIFont = .fontBody2,
                     text: String,
                     textEnableColor: UIColor = .white,
                     textDisableColor: UIColor = .Text.disable10,
                     onKeyboard: Bool = false) {
        
        self.init(frame: frame)
        
        self.enableColor = enableColor
        self.disableColor = disableColor
        self.font = font
        self.text = text
        self.textEnableColor = textEnableColor
        self.textDisableColor = textDisableColor
        self.setAttribute()
        if onKeyboard {
            self.observePosition()
        }
    }
    
    func setAttribute() {
        self.titleLabel?.font = font
        self.setTitle(text, for: .normal)
        self.setTitleColor(isEnable ? textEnableColor : textDisableColor, for: .normal)
        self.backgroundColor = isEnable ? enableColor : disableColor
        self.layer.cornerRadius = 5.0
    }
    
    func enable() {
        isEnable = true
        setAttribute()
    }
    
    func disable() {
        isEnable = false
        setAttribute()
    }
    
    func keyboardHeight() -> Observable<CGFloat> {
        return Observable
                .from([
                    NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                                .map { notification -> CGFloat in
                                    (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                                },
                    NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                                .map { _ -> CGFloat in
                                    0
                                }
                ])
                .merge()
    }
    
    func observePosition(){
        keyboardHeight()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { keyboardHeight in
                    let safeAreaBottom = UIDevice.current.notchHeightBottom
                    let height = keyboardHeight > 0.0 ? (keyboardHeight - safeAreaBottom) : safeAreaBottom
                    self.updateConstraints(-height)
                })
                .disposed(by: disposeBag)
    }
                
    func updateConstraints(_ offset: CGFloat){
        self.snp.remakeConstraints {
            $0.bottom.equalToSuperview().offset(offset - 16)
            $0.height.equalTo(44)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
}
