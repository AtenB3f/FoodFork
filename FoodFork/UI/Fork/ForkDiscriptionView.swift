//
//  ForkDiscriptionView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/12.
//

import UIKit

class ForkDiscriptionView: UIView, ViewLayout {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let height:CGFloat = 126
    
    private lazy var info: UILabel = {
        let label = UILabel()
        
        label.text = "나만의 맛집 기록을 남겨보세요!"
        label.font = .fontSubtitle2
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        
        let label: UILabel = {
            let label = UILabel()
            
            label.text = "포크 추가"
            label.font = .fontBody2
            label.textColor = .Base.light20
            
            return label
        }()
        
        let icon: UIImageView = {
            let image = UIImage(named: "Fork")!
                .withTintColor(.Brand.light20)
            
            let icon = UIImageView(image: image)
            
            icon.backgroundColor = .white
            icon.layer.cornerRadius = 12
            icon.contentMode = .scaleAspectFill
            
            return icon
        }()
        button.addSubview(icon)
        button.addSubview(label)
        
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(8)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(8)
        }
        
        button.backgroundColor = .Brand.main30
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    func setLayout() {
        self.addSubview(info)
        self.addSubview(button)
        
        info.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        button.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(info.snp.bottom).offset(16)
            make.width.equalTo(116)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setAttribute() {
        
    }
    
    
}




#if DEBUG
import SwiftUI

struct PreView: PreviewProvider {
    static var previews: some View {
        ForkViewController().toPreview()
    }
}

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif

