//
//  UIStoryboard.swift
//  CoordinatorTransitons
//
//  Created by Pavle Pesic on 5/18/18.
//  Copyright © 2018 Pavle Pesic. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    // MARK: - Vars & Lets
    
    static var main: UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
    
    static var onBoarding: UIStoryboard {
        return UIStoryboard.init(name: "OnBoarding", bundle: nil)
    }
    
    
}

extension UIView {
    
    func addShadow(shadowColor: UIColor, opacity: Float, shadowRadius: CGFloat, size: CGSize, cornerRadius: CGFloat) {
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
        layer.shadowOffset = size
        layer.shadowColor = shadowColor.cgColor
    }
}
