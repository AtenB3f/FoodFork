//
//  StarRateView.swift
//  FoodFork
//
//  Created by Ivy Moon on 10/12/24.
//

import UIKit

public class StarRateView: UIView {
    private var spacing: CGFloat = 6
    private var iconSize: CGFloat = 40
    var rate: CGFloat = .zero
    var count: Int = 0
    private var total: Double = 5
    private var enableColor: UIColor = .Brand.main30
    private var disableColor: UIColor = .Base.dark40
    private var setRate:((Double)->Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public convenience init(frame: CGRect = .zero,
                     count: Int = 0,
                     total: Int = 5,
                     enableColor: UIColor = .Brand.main30,
                     disableColor: UIColor = .Base.dark40,
                     setRate: ((Double)->Void)? = nil) {
        self.init(frame: frame)
        self.count = count
        self.total = Double(total)
        self.enableColor = enableColor
        self.disableColor = disableColor
        self.rate = CGFloat(count)/CGFloat(total)
        self.setRate = setRate
        
        for i in 0..<total {
            let star : UIImageView = {
                let icon = UIImageView()
                icon.image = UIImage(named: "Star_On")!.withRenderingMode(.alwaysTemplate)
                icon.contentMode = .scaleAspectFill
                icon.tag = i
                icon.frame.size = CGSize(width: iconSize, height: iconSize)
                icon.tintColor = i < Int(rate) ? enableColor : disableColor
                
                return icon
            }()
            stackView.addArrangedSubview(star)
        }
        
        setLayout()
        setAttribute()
    }
    
    func setLayout() {
        addSubview(stackView)
        
        let w = CGFloat(total)*iconSize + spacing*CGFloat(total - 1)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(w)
            $0.height.equalTo(iconSize)
        }
    }
    
    func setAttribute() {
    }
    
    func setGesture(_ viewController: UIViewController) {
//        let gesture = UIPanGestureRecognizer(target: viewController, action: #selector(panHandler(_:)))
//        stackView.addGestureRecognizer(gesture)
    }
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = CGFloat(self.spacing)
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    public func tapHandler(_ sender: UIGestureRecognizer) {
        let location = sender.location(in: self)
        var value = Double(location.x / (stackView.frame.maxX - stackView.frame.minX) * CGFloat(total))
        value = value < 0 ? 0 : value
        value = value < total ? value : total
        
        for i in 0..<stackView.arrangedSubviews.count {
            let star = stackView.arrangedSubviews[i]
            stackView.arrangedSubviews[i].tintColor = star.tag < Int(value) ? enableColor : disableColor
        }
        setRate?(value)
    }
    
    public func panHandler(_ sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: self)
        let location = sender.location(in: self)
        var value = Int((point.x + location.x) / (stackView.frame.maxX - stackView.frame.minX) * CGFloat(total))
        value = value < 0 ? 0 : value
        value = value < Int(total) ? value : Int(total)
        
        for i in 0..<stackView.arrangedSubviews.count {
            let star = stackView.arrangedSubviews[i]
            stackView.arrangedSubviews[i].tintColor = star.tag < value ? enableColor : disableColor
        }
        setRate?(Double(value))
    }
}
