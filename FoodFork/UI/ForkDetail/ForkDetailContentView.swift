//
//  ForkDetailContentView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/20/24.
//

import UIKit
import KakaoMapsSDK
import RxSwift
import RxCocoa

class ForkDetailContentView: UIView, ViewLayout {
    let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
        setBind()
    }
    
    func setLayout() {
        [list, store, starRate, category, divider, review, copyButton, map, address].forEach { addSubview($0) }
        
        list.snp.makeConstraints {
            $0.width.left.right.top.equalToSuperview()
            $0.height.equalTo(list.snp.width).multipliedBy(1)
        }
        
        store.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(44)
            $0.top.equalTo(list.snp.bottom).offset(40)
        }
        
        starRate.snp.makeConstraints {
            $0.top.equalTo(store.snp.bottom).offset(14)
            $0.height.equalTo(12)
            $0.left.equalToSuperview().inset(16)
        }
        
        category.snp.makeConstraints {
            $0.top.equalTo(starRate.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(16)
        }
        
        divider.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(category.snp.bottom).offset(8)
        }
        
        review.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(14)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        copyButton.snp.makeConstraints {
            $0.top.equalTo(review.snp.bottom).offset(48)
            $0.right.equalToSuperview().inset(26)
        }
        
        map.snp.makeConstraints {
            $0.top.equalTo(copyButton.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(240)
        }
        
        address.snp.makeConstraints {
            $0.top.equalTo(map.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(44)
        }
    }
    
    func setAttribute() {
        
    }
    
    func setBind() {
        viewModel?.pictures
            .bind(to: list.rx.items(cellIdentifier: AddForkPictureItemView.id, cellType: AddForkPictureItemView.self)) { _, image, cell in
                cell.imageView.image = image
                
            }
            .disposed(by: disposeBag)
    }
    
    func setData(_ data: ForkInfoModel?) {
        if let info = data {
            store.text = info.storeName
            starRate.setText(rate: info.rate ?? .zero)
            review.setText(info.review ?? "")
            address.setText(info.address ?? "")
            if let pics = info.pictures {
                viewModel?.pictures.accept(pics)
            }
            category.text = info.category?.components(separatedBy: " > ").last ?? ""
        }
    }
    
    var viewModel: ForkDetailViewModel? {
        didSet {
            setBind()
            setData(viewModel?.forkInfo)
        }
    }
    
    lazy var list : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    lazy var store: UILabel = {
        let label = UILabel()
        label.font = .fontHeader2
        label.textColor = .Text.medium30
        
        return label
    }()
    
    lazy var starRate = StarRateLabel(rate: .zero)
    
    lazy var category = RoundSquareLabel(text: viewModel?.forkInfo?.category?.components(separatedBy: " > ").last ?? "",
                                         textColor: .white,
                                         backgroundColor: .Brand.main30)
    
    lazy var divider = DividerView()
    
    lazy var review = ForkTextView(color: .Text.light20,
                                   text: viewModel?.forkInfo?.review ?? "")
    
    lazy var copyButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("주소 복사", for: .normal)
        button.setTitleColor(.Text.medium30, for: .normal)
        
        return button
    }()
    
    lazy var map: KMViewContainer = KMViewContainer()
    
    lazy var address = ForkTextView(color: .Text.medium30,
                                    text: viewModel?.forkInfo?.address ?? "")
}
