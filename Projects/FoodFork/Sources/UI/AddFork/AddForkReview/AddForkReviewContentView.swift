//
//  AddForkReviewContentView.swift
//  FoodFork
//
//  Created by Ivy Moon on 1/6/25.
//
import UIKit
import Design
import RxSwift
import SnapKit

class AddForkReviewContentView: UIView, ViewLayout {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }

    let disposeBag = DisposeBag()

    func setLayout() {
        self.addSubview(guideText)
        self.addSubview(input)
        self.addSubview(divider)

        guideText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(58+60)
            $0.left.equalToSuperview().inset(16)
        }

        input.snp.makeConstraints {
            $0.top.equalTo(guideText.snp.bottom).offset(50)
            $0.left.right.equalToSuperview().inset(16)
//            $0.height.equalTo(46)
        }

        divider.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(2)
            $0.top.equalTo(input.snp.bottom).offset(1)
        }
    }

    func setAttribute() {
    }

    lazy var guideText = ForkTextView(font: .fontHeader2, text: "선택하신 매장의\n음식은 어땠나요?")

    lazy var input = TextInputView(font: .fontSubtitle1,
                                   placeholder: "음식, 서비스, 매장 분위기 등\n솔직한 내용을 자유롭게 작성해주세요!",
                                   onChange: { text in
        self.setReview(text)
    })

    lazy var divider = DividerView(color: .Brand.main30)

    var viewModel: AddForkReviewViewModel?
    var parentViewModel: AddForkViewModel?

    func setReview(_ text: String) {
        self.viewModel?.reviews.accept(text)
        let screenHeight = Float(UIScreen.screenHeight)
        let height = Float(input.frame.height)
        viewModel?.detailHeight.accept(height + screenHeight)
    }
}
