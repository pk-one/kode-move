//
//  UIView + Extension.swift
//  kode-move
//
//  Created by Pavel Olegovich on 03.11.2021.
//

import UIKit

extension UIView {
    func createGradientLayer(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.locations = [0.80, 1]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
}
