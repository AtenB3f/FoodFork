//
//  ForkItemView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/14.
//

import UIKit

class ForkItemView: UITableViewCell, ViewLayout {

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

    static let id = "ForkItemView"

    var index: Int?

    var data: ForkInfoModel?

    private lazy var thumbnail: UIImageView = {
        let thumbnail = UIImageView()

        thumbnail.layer.cornerRadius = 5
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true

        return thumbnail
    }()

    private lazy var name: UILabel = {
        let label = UILabel()

        label.font = .fontBody2
        label.textColor = .Text.medium30

        return label
    }()

    private lazy var rate = StarRateLabel(rate: .zero)

    func setLayout() {
        self.addSubview(thumbnail)
        self.addSubview(name)
        self.addSubview(rate)

        thumbnail.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
//            make.height.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(180)
        }

        name.snp.makeConstraints { make in
            make.left.equalTo(thumbnail.snp.left).inset(5)
            make.top.equalTo(thumbnail.snp.bottom).offset(6)
            make.right.equalTo(rate.snp.left).offset(10)
        }

        rate.snp.makeConstraints { make in
            make.right.equalTo(thumbnail.snp.right).inset(5)
            make.width.equalTo(46)
            make.centerY.equalTo(name)
        }
    }

    func setAttribute() {
        self.contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))
        self.backgroundColor = .clear
        thumbnail.backgroundColor = .blue
        name.text = data?.name ?? ""
        rate.setText(rate: data?.rate ?? .zero)
        thumbnail.image = UIImage(named: "Star_Off")!
    }

    func setData(_ data: ForkInfoModel) {
        setLayout()
        setAttribute()
        name.text = data.name
        rate.setText(rate: data.rate)
        thumbnail.image = UIImage(named: "Star_Off")!
    }
}
