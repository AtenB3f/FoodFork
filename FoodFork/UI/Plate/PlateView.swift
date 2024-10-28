//
//  PlateView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/12.
//

import UIKit
import RxSwift
import KakaoMapsSDK

class PlateView: UIView, ViewLayout {
    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
        setAttribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var navigation: NavigationDelegate? {
        didSet {
            detail.navigation = navigation
        }
    }
    
    func setLayout() {
        self.addSubview(header)
        self.addSubview(map)
        self.addSubview(footer)
        footer.addSubview(filpButton)
        footer.addSubview(list)
        footer.addSubview(detail)
        
        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(header.height)
        }

        map.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(header.snp.bottom)
            $0.bottom.equalToSuperview().inset(100)
        }
        
        footer.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(UIView.tabbarHeight)
            $0.height.equalTo(280)
        }
        
        filpButton.snp.makeConstraints {
            $0.width.horizontalEdges.top.equalToSuperview()
            $0.height.equalTo(36)
        }
        
        list.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(36)
            $0.bottom.equalToSuperview()
        }
        
        detail.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(36)
            $0.bottom.equalToSuperview()
        }
    }

    func setAttribute() {
        detail.isHidden = true
        footer.backgroundColor = .Base.light20
        footer.layer.cornerRadius = 15
        footer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // MARK: TODO - footer 윗부분 제스처 추가
    }

    lazy var header = HeaderView(title: "플레이트")

    lazy var map: KMViewContainer = KMViewContainer()
    
    lazy var footer = UIView()
    
    lazy var filpButton: UIButton = {
        let button = UIButton()
        let line = DividerView()
        
        button.addSubview(line)
        
        line.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(2)
        }
        
        return button
    }()
    
    lazy var list: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .Base.light20
        return table
    }()
    
    lazy var detail = PlateDetailView()
    
    func showDetail(_ isShow: Bool) {
        detail.isHidden = !isShow
    }
}
