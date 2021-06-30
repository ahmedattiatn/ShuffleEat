//
//  ImageCardView.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 07/09/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

@IBDesignable
class ImageCardView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = Constants.IBDesignable.radius.rawValue
    
    
    override func layoutSubviews() {
        self.layoutIfNeeded()
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
}
