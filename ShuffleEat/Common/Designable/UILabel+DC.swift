//
//  UILabel+DC.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 11/09/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

//


import UIKit

@IBDesignable

class DCLabelStyle: UILabel {
    @IBInspectable var shadowOpacity: Float = 0.5
    @IBInspectable var shadowRadius: CGFloat = 3.0
    
    override func layoutSubviews() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.masksToBounds = false
    }
    
}
