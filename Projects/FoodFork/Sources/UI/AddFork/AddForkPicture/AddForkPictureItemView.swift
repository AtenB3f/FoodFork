//
//  AddForkPictureItemView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/11/24.
//

import UIKit

class AddForkPictureItemView: UICollectionViewCell {
    static public let id = "AddForkPictureItemView"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setAttribute()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    let imageView = UIImageView()
    
    func setLayout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(1)
        }
    }
    
    func setAttribute() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
}
