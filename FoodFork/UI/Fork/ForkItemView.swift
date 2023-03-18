//
//  ForkItemView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/14.
//

import UIKit

struct ForkInfoModel {
    var name: String
    var address: String
    var rate: Double
}

class ForkItemView: UIView, ViewLayout {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect = .zero, data: ForkInfoModel) {
        self.init(frame: frame)
        
        self.data = data
        
        setLayout()
        setAttribute()
    }
    
    
    private lazy var data: ForkInfoModel? = nil
    
    private lazy var thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        
        thumbnail.layer.cornerRadius = 5
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true
        
        return thumbnail
    }()
    
    private lazy var name: UILabel = UILabel()
    
    private lazy var rate = StarRateLabel(rate: .zero)
    
    
    func setLayout() {
        self.addSubview(thumbnail)
        self.addSubview(name)
        self.addSubview(rate)
        
        thumbnail.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(self.snp.width).multipliedBy(0.5)
        }
        
        name.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(5)
            make.top.equalTo(thumbnail.snp.bottom).offset(6)
        }
        
        rate.snp.makeConstraints { make in
            make.left.equalTo(name.snp.right).offset(10)
            make.right.equalToSuperview().inset(5)
            make.top.equalTo(thumbnail.snp.bottom).offset(6)
        }
    }
    
    func setAttribute() {
        name.text = data?.name ?? ""
        rate.setText(rate: data?.rate ?? .zero)
        name.backgroundColor  = .yellow
        thumbnail.image = UIImage(named: "Star_Off")!
        thumbnail.backgroundColor = .blue
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

