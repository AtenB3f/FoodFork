//
//  PlateDetailView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/22/24.
//

import UIKit
import Design
import Data

class PlateDetailView: UIView, ViewLayout {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setAttribute()
    }
    
    var viewModel: PlateViewModel?
 
    var navigation: NavigationDelegate?
    
    func setLayout() {
        self.addSubview(scroll)
        scroll.addSubview(contents)
        
        [thumbnail, close, name, category, address, copy, divider, rate, heart, review, detail]
            .forEach { contents.addSubview($0) }
        
        scroll.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        contents.snp.makeConstraints {
            $0.horizontalEdges.top.width.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        thumbnail.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.left.equalToSuperview().inset(24)
            $0.width.height.equalTo(80)
        }
        
        close.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview().offset(2)
            $0.right.equalToSuperview().inset(24)
        }
        
        name.snp.makeConstraints {
            $0.top.equalTo(thumbnail.snp.top).offset(5)
            $0.left.equalTo(thumbnail.snp.right).offset(16)
        }
        
        category.snp.makeConstraints {
            $0.centerY.equalTo(name.snp.centerY)
            $0.left.equalTo(name.snp.right).offset(12)
        }
        
        address.snp.makeConstraints {
            $0.left.equalTo(thumbnail.snp.right).offset(16)
            $0.top.equalTo(name.snp.bottom).offset(10)
            $0.right.equalToSuperview().inset(72)
        }
        
        copy.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(10)
            $0.right.equalToSuperview().inset(24)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(address.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        rate.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(6)
            $0.left.equalToSuperview().inset(24)
            $0.height.equalTo(36)
        }
        
        heart.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(6)
            $0.right.equalToSuperview().inset(24)
            $0.width.height.equalTo(40)
        }
        
        review.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.top.equalTo(heart.snp.bottom).offset(12)
        }
        
        detail.snp.makeConstraints {
            $0.top.equalTo(review.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(24)
        }
    }
    
    func setAttribute() {
        self.backgroundColor = .Base.light20
    }
    
    func setData(_ info: ForkInfoModel) {
        if let image = info.pictures?.first {
            thumbnail.image = image
        }
        name.text = info.storeName ?? ""
        category.text = info.category?.components(separatedBy: " > ").last ?? ""
        address.text = info.address ?? ""
        rate.setText(rate: info.rate ?? .zero)
        review.text = info.review ?? ""
        
        self.layoutIfNeeded()
        let size = CGSize(width: contents.frame.width, height: detail.frame.maxY+16)
        contents.frame.size = size
        scroll.contentSize = contents.frame.size
    }
    
    lazy var close: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.addTarget(self, action: #selector (actionClose), for: .touchUpInside)
        return button
    }()
    
    lazy var thumbnail: UIImageView = {
        let thumbnail = UIImageView()

        thumbnail.layer.cornerRadius = 5
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true

        return thumbnail
    }()

    lazy var name: UILabel = {
        let label = UILabel()

        label.font = .fontSubtitle1
        label.textColor = .Text.medium30

        return label
    }()
    
    lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy var contents = UIView()
    
    lazy var category = RoundSquareLabel(textColor: .white ,
                                         backgroundColor: .Brand.main30)
    
    lazy var address = ForkTextView(color: .Text.disable10, font: .fontBody2)
    
    lazy var copy: UIButton = {
        let button = UIButton()
        let view = RoundSquareLabel(text: "복사")
        
        button.addSubview(view)
        button.addTarget(self, action: #selector(actionCopy), for: .touchUpInside)
        
        view.snp.makeConstraints {
            $0.horizontalEdges.centerY.equalToSuperview()
        }
        
        return button
    }()
    
    lazy var divider = DividerView()
    
    lazy var rate = BigStarLabel(rate: .zero)
    
    lazy var heart: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Heart_On"), for: .normal)
        button.addTarget(self, action: #selector(actionHeartToggle), for: .touchUpInside)
        return button
    }()
    
    lazy var review = ForkTextView(color: .Text.light20)
    
    lazy var detail:UIButton = {
        let button = UIButton()
        button.setTitle("자세히 보기", for: .normal)
        button.setTitleColor(.Text.medium30, for: .normal)
        button.titleLabel?.font = .fontBody2
        button.addTarget(self, action: #selector(actionDetail), for: .touchUpInside)
        return button
    }()
    
    @objc func actionClose() {
        self.isHidden = true
        viewModel?.selectFork.accept(nil)
    }
    
    @objc func actionHeartToggle() {
        print("toggle")
    }
    
    @objc func actionDetail() {
        if let info = viewModel?.selectFork.value {
            print("actionDetail")
            navigation?.pushNavigation(target: .detailFork(forkInfo: info))
        }
    }
    
    @objc func actionCopy() {
        print("actionCopy")
        
    }
}
