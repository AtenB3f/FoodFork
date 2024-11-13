//
//  PlateItemView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/21/24.
//

import UIKit
import Design
import Data

class PlateItemView: UITableViewCell, ViewLayout {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setLayout()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(style: UITableViewCell.CellStyle = .default,
                     reuseIdentifier: String? = nil,
                     data: ForkInfoModel) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        self.data = data

        setLayout()
        setAttribute()
    }

    static let id = "PlateItemView"
    
    var data: ForkInfoModel? {
        didSet {
            setAttribute()
        }
    }
    
    func setLayout() {
        self.addSubview(thumbnail)
        self.addSubview(name)
        self.addSubview(rate)
        self.addSubview(category)
        self.addSubview(divider)
        
        thumbnail.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(80)
        }

        name.snp.makeConstraints { make in
            make.left.equalTo(thumbnail.snp.right).offset(16)
            make.top.equalToSuperview().inset(15)
            
        }

        rate.snp.makeConstraints { make in
            make.left.equalTo(thumbnail.snp.right).offset(16)
            make.centerY.equalTo(category.snp.centerY)
            make.width.equalTo(38)
        }
        
        category.snp.makeConstraints {
            $0.left.equalTo(rate.snp.right).offset(23)
            $0.bottom.equalTo(thumbnail.snp.bottom).inset(4)
        }
        
        divider.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
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
        rate.setText(rate: info.rate ?? .zero)
        category.text = info.category?.components(separatedBy: " > ").last ?? ""
    }
    
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
    
    lazy var rate = StarRateLabel(rate: .zero)
    
    lazy var category = RoundSquareLabel(backgroundColor: .Gray.disable10)
    
    lazy var divider = DividerView()
}
