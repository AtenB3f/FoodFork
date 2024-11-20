//
//  AddForkStarRateView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit
import Design

class AddForkStarRateView: UIView, ViewLayout {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }

    var parentViewModel: AddForkViewModel? {
        didSet {
            guideText.text = "\(parentViewModel?.fork.storeName ?? "")의\n총점을 알려주세요!"
        }
    }
    var viewModel: AddForkStarRateViewModel? {
        didSet {
            rateText.text = String(viewModel?.starRate ?? .zero)
        }
    }

    func setLayout() {
        self.addSubview(header)
        self.addSubview(guideText)
        self.addSubview(star)
        self.addSubview(rateText)
        self.addSubview(button)

        header.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(header.height)
        }

        guideText.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(header.snp.bottom).offset(58)
        }

        star.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(guideText.snp.bottom).offset(60)
        }

        rateText.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(star.snp.bottom).offset(20)
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

    lazy var header = PrevHeaderView(title: "별점 입력(3/4)", callback: {
        self.navigation?.popNavigation(isRoot: false)
    })

    lazy var guideText: UITextView = {
        let label = UITextView()
        label.text = "선택하신 매장의\n총점을 알려주세요!"
        label.font = .fontHeader2
        label.textColor = .Text.medium30
        label.isScrollEnabled = false
        label.textAlignment = .center
        label.isEditable = false
        return label
    }()

    lazy var star = StarRateView(count: 0,
                                 total: 5,
                                 setRate: { rate in
        self.viewModel?.starRate = rate
        self.rateText.text = rate.toStarRateString
    })

    lazy var rateText: UILabel = {
        let text = UILabel()
        text.text = "0.0"
        text.font = .fontHeader2
        text.textColor = .Text.light20
        text.textAlignment = .center

        return text
    }()

    lazy var button = RoundSquareButton(text: "다음")

    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
//            directInput.navigation = navigation
        }
    }

    @objc func onClick() {
        parentViewModel?.setForkInfo(rate: Double(rateText.text ?? "0.0"))
        self.navigation?.pushNavigation(target: .addForkReview(parentViewModel: parentViewModel ?? AddForkViewModel()))
    }
}
