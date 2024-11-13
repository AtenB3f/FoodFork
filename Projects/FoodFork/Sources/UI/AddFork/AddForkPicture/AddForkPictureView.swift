//
//  AddForkPictureView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/2/24.
//

import UIKit
import Design

class AddForkPictureView: UIView, ViewLayout{
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
            guideText.text = "\(parentViewModel?.fork.storeName ?? "")의\n음식 사진을 추가해주세요!"
        }
    }
    var viewModel: AddForkPictureViewModel?
    
    func setLayout() {
        self.addSubview(header)
        self.addSubview(guideText)
        self.addSubview(button)
        self.addSubview(list)
        
        header.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(header.height)
        }
        
        guideText.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(header.snp.bottom).offset(58)
        }
        
        button.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        list.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(guideText.snp.bottom).offset(3)
            $0.height.equalTo(list.snp.width).multipliedBy(1)
        }
    }
    
    func setAttribute() {
        button.enable()
        
    }
    
    lazy var header = PrevHeaderView(title: "사진 추가(2/4)", callback: {
        self.navigation?.popNavigation(isRoot: false)
    })
    
    lazy var guideText: UITextView = {
        let label = UITextView()
        label.text = "선택하신 매장의\n음식 사진을 추가해주세요!"
        label.font = .fontHeader2
        label.textColor = .Text.medium30
        label.isScrollEnabled = false
        label.textAlignment = .left
        label.isEditable = false
        return label
    }()
    
    lazy var button = RoundSquareButton(text: "사진 선택하기")
    
    lazy var list : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
        }
    }
}
