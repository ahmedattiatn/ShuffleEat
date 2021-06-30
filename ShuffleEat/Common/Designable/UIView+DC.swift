//
//  UIView+DC.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 14/09/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

class DCUIViewStyle: UIView {
    
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [Colors.darkPrimaryColor.cgColor, Colors.endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5,y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5,y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
