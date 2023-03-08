//
//  TabBarItemView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/08.
//

import UIKit
import SnapKit

class TabBarItemView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(frame: CGRect = .zero, type: TabBarType) {
        self.init(frame: frame)
        self.type = type
        
        setLayout()
        setAttribute()
    }
    
    private var type: TabBarType? = nil
    private var isSelected: Bool = false
    
    let view: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .center
        
        return view
    }()
    
    func setLayout() {
        self.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
    
    func setAttribute() {
        view.image = type?.icon(false)
    }
}
