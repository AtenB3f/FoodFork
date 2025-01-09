//
//  AddForkReviewView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit
import Design
import RxSwift

class AddForkReviewView: UIView, ViewLayout {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
//        setAttribute()
    }

    var disposeBag = DisposeBag()

    func setLayout() {
        self.addSubview(scroll)
        scroll.addSubview(contents)
        contents.addSubview(detail)
        self.addSubview(button)
        self.addSubview(header)
        self.addSubview(top)

        top.snp.makeConstraints {
            $0.top.width.centerX.equalToSuperview()
            $0.height.equalTo(UIDevice.current.safeAreaTopInset)
        }

        header.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.top.equalToSuperview().inset(UIDevice.current.safeAreaTopInset)
            $0.height.equalTo(60)
        }

        scroll.snp.makeConstraints {
            $0.top.bottom.height.width.equalToSuperview()
        }

        contents.snp.makeConstraints {
            $0.top.bottom.height.width.equalToSuperview()
        }

        detail.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.height.equalTo(UIScreen.screenHeight)
        }

        button.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(16)
        }
    }

    func setAttribute() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        contents.addGestureRecognizer(tap)

        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(keyboardWillShow),
                         name: UIResponder.keyboardWillShowNotification,
                         object: nil)
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(keyboardWillHide),
                         name: UIResponder.keyboardWillHideNotification,
                         object: nil)

        viewModel?.detailHeight.bind(onNext: { height in
            guard height > .zero else { return }

            self.detail.snp.remakeConstraints {
                $0.top.width.equalToSuperview()
                $0.height.equalTo(height)
            }
            if self.contents.frame.height < CGFloat(height) {
                self.contents.snp.remakeConstraints {
                    $0.top.bottom.width.centerX.equalToSuperview()
                    $0.height.equalTo(height)
                }
            }
            self.scroll.scroll(to: .bottom)
        })
        .disposed(by: disposeBag)

        viewModel?.reviews.bind(onNext: { text in
            self.button.setTitle(text.isEmpty ? "생략하기" : "완료", for: .normal)
        })
        .disposed(by: disposeBag)

        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        button.enable()
    }

    func reloadView() {
        NotificationCenter.default.post(name: .reloadView, object: nil)
    }

    let top: UIView = {
        let view = UIView()
        view.backgroundColor = .Base.light20
        return view
    }()

    lazy var header = PrevHeaderView(title: "후기 입력(4/4)", callback: {
        self.navigation?.popNavigation(isRoot: false)
    })

    let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = false
        scroll.isScrollEnabled = true
        return scroll
    }()

    let contents = UIView()

    let detail = AddForkReviewContentView()

    let button = RoundSquareButton(text: "생략하기",
                                        onKeyboard: true)

    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
        }
    }

    var viewModel: AddForkReviewViewModel? {
        didSet {
            detail.viewModel = viewModel
            setAttribute()
        }
    }

    var parentViewModel: AddForkViewModel? {
        didSet {
            detail.parentViewModel = parentViewModel
            detail.guideText.text = "\(parentViewModel?.fork.storeName ?? "")의\n음식은 어땠나요?"
        }
    }

    @objc func onClick() {
        parentViewModel?.setForkInfo(review: detail.input.text)
        parentViewModel?.saveFork()
        self.navigation?.popNavigation(isRoot: true)
    }

    @objc func tapView() {
        print("tapView")
        self.endEditing(true)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            contents.snp.remakeConstraints {
                $0.top.bottom.width.height.centerX.equalToSuperview()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if contents.frame.height - 250 > UIScreen.screenHeight {
            contents.snp.remakeConstraints {
                $0.top.bottom.width.centerX.equalToSuperview()
                $0.height.equalTo(contents.frame.height - 250)
            }
        }
        
    }
}
