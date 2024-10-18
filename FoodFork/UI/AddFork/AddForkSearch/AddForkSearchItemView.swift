//
//  AddForkSearchItemView.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/04/02.
//

import UIKit

class AddForkSearchItemView: UITableViewCell, ViewLayout {

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
                     data: PlaceInfoModel) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        self.data = data

        setLayout()
        setAttribute()
    }

    func setLayout() {
        self.addSubview(store)
        self.addSubview(address)
        self.addSubview(label)
        self.addSubview(lotNumber)
        self.addSubview(divider)

        store.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(20)
        }

        address.snp.makeConstraints {
            $0.top.equalTo(store.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(store.snp.horizontalEdges)
        }

        label.snp.makeConstraints {
            $0.top.equalTo(address.snp.bottom).offset(4)
            $0.left.equalTo(address.snp.left)
        }

        lotNumber.snp.makeConstraints {
            $0.top.equalTo(address.snp.bottom).offset(4)
            $0.left.equalTo(label.snp.right).offset(4)
            $0.right.equalTo(address.snp.right)
        }

        divider.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }

    func setAttribute() {
        self.backgroundColor = .white
    }

    var navigation: NavigationDelegate? {
        didSet {
            // subView navigatin link
        }
    }

    static let id: String = "AddForkSearchItemView"

    static let height: CGFloat = 104

    var index: Int?

    var data: PlaceInfoModel?

    func setData(_ data: PlaceInfoModel) {
        setLayout()
        setAttribute()
        store.text = data.placeName
        address.text = data.address
    }

    lazy var store: UILabel = {
        let label = UILabel()

        label.textColor = .Text.dark40
        label.font = .fontSubtitle1

        return label
    }()

    lazy var address: UILabel = {
        let label = UILabel()

        label.textColor = .Text.light20
        label.font = .fontBody2

        return label
    }()

    lazy var label: UIButton = {
        let label = UIButton()

        label.setTitle("지번", for: .normal)
        label.setTitleColor(.Other.divider, for: .normal)
        label.titleLabel?.font = .fontBody1
        label.contentEdgeInsets = UIEdgeInsets(top: 1, left: 4, bottom: 1, right: 4)
        label.layer.cornerRadius = 2
        label.layer.borderColor = UIColor.Other.divider.cgColor
        label.layer.borderWidth = 1
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return label
    }()

    lazy var lotNumber: UILabel = {
        let label = UILabel()

        label.textColor = .Text.disable10
        label.font = .fontBody2
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)

        return label
    }()

    lazy var divider = DividerView()
}
