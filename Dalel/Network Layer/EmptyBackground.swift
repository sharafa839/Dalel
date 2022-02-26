//
//  EmptyBackground.swift
//  Dalel
//
//  Created by  on 25/02/2022.
//

import Foundation
import UIKit
class EmptyBackgroundView: UIView {
    
    var emptyImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var titleLabel:UILabel = {
        let label = UILabel()
        label.tag = 10
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    var subTitleLabel:UILabel = {
        let label = UILabel()
        label.tag = 10
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var actionButton:UIButton?
    
    lazy var stackViewContainer :UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emptyImageView, titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    required init(imageView:UIImageView, title:String, subTitle:String? = nil, actionButton: UIButton? = nil, withAnimation: Bool = false) {
        super.init(frame: .zero)
        setupUI(imageView: imageView, title: title, subTitle: subTitle, withAnimation: withAnimation)
        self.actionButton = actionButton
        setupConstraints()
    }
    
    func setupUI(imageView:UIImageView, title:String, subTitle:String? = nil, actionButton: UIButton? = nil, withAnimation: Bool) {
        backgroundColor = .black
        emptyImageView = imageView
        titleLabel.text = title
        subTitleLabel.text = subTitle
        guard withAnimation else { return }
        UIView.animate(withDuration: 1, animations: {
            self.emptyImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }, completion: { (finish) in
            UIView.animate(withDuration: 1, animations: { [self] in
                self.emptyImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
            }, completion: { (finish) in
                UIView.animate(withDuration: 1, animations: {
                    self.emptyImageView.transform = CGAffineTransform.identity
                })
            })
        })
    }
    
    func setupConstraints() {
        addSubview(stackViewContainer)
        if let actionButton = actionButton {
            stackViewContainer.insertArrangedSubview(actionButton, at: stackViewContainer.arrangedSubviews.count)
        }
        stackViewContainer.centerYInSuperview()
        stackViewContainer.alignment = .center
        stackViewContainer.distribution = .fill
        stackViewContainer.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension UIView {
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, trailingLessThanOrEqualTo:Bool = false, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingLessThanOrEqualTo ? trailingAnchor.constraint(lessThanOrEqualTo: trailing, constant: -padding.right) : trailingAnchor.constraint(equalTo: trailing, constant: padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
}
struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}
