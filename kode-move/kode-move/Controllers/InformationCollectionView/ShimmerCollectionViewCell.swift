//
//  ShimmerCollectionViewCell.swift
//  kode-move
//
//  Created by Pavel Olegovich on 06.11.2021.
//

import UIKit
import Kingfisher

class ShimmerCollectionViewCell: UICollectionViewCell {
    
    private let profileView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 7, y: 10, width: 50, height: 50)
        view.layer.cornerRadius = 25
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        return view
    }()
    
    private let shinyProfileView: UIView = {
        let view = UILabel()
        view.frame = CGRect(x: 7, y: 10, width: 50, height: 50)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(white: 1, alpha: 0.2)
        return view
    }()
    
    
    private let nameView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 65, width: 65, height: 10)
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        return view
    }()
    
    private let shinyNameView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 65, width: 65, height: 10)
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(white: 1, alpha: 0.2)
        return view
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 80, width: 65, height: 10)
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        return view
    }()
    
    
    private let shinyDescriptionView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 80, width: 65, height: 10)
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(white: 1, alpha: 0.2)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        //        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(profileView)
        self.addSubview(shinyProfileView)
        self.addSubview(nameView)
        self.addSubview(shinyNameView)
        self.addSubview(descriptionView)
        self.addSubview(shinyDescriptionView)
        
        generateShimmer(shinyView: shinyProfileView, duration: 3, angleRotation: 110, sx: 2, sy: 2)
        self.generateShimmer(shinyView: self.shinyNameView, duration: 3, angleRotation: 110, sx: 10, sy: 10)
        self.generateShimmer(shinyView: self.shinyDescriptionView, duration: 3, angleRotation: 110, sx: 10, sy: 10)
    }
}

//MARK: - generateShimmer
extension ShimmerCollectionViewCell {
    private func generateShimmer(shinyView: UIView, duration: CFTimeInterval, angleRotation: CGFloat, sx: CGFloat, sy: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.cgColor,
            UIColor.white.cgColor,
            UIColor.white.cgColor,
            UIColor.white.cgColor,
            UIColor.clear.cgColor
        ]
        
        gradientLayer.locations = [0, 0.2, 0.4, 0.6, 0.8, 1]
        gradientLayer.frame = shinyView.frame
        
        let angle = angleRotation * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        gradientLayer.transform = CATransform3DConcat(gradientLayer.transform, CATransform3DMakeScale(sx, sy, 0))
        shinyView.layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue =  -frame.width - 40
        animation.toValue = frame.width + 40
        animation.repeatCount = Float.infinity
        animation.duration = duration
        
        gradientLayer.add(animation, forKey: "animationn")
    }
}
