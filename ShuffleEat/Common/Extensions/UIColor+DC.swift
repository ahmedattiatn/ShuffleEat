//
//  UIColor+DC.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 31/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

import Foundation
extension UIColor {

    // MARK: - INIT
    convenience init(red: Int, green: Int, blue: Int, transparency: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: transparency)
    }

    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff, transparency: 1)
    }

    convenience init(transparencyWithHex hex: Int, transparency: CGFloat = 0.1) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff, transparency: transparency)
    }

    convenience init(hexString: String) {
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        self.init(hex: Int(rgbValue))
    }

    /****   Adjust Color For Animation Button   ****/

    /// Lightens a colour by a `percentage`.
    ///
    /// - Parameters:
    ///     - percentage: the amount to lighten a colour by.
    ///
    /// - Returns: A colour lightened by a `percentage`.
    ///
    public func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage))
    }

    /// Darkens a colour by a `percentage`.
    ///
    /// - Parameters:
    ///     - percentage: the amount to darken a colour by.
    ///
    /// - Returns: A colour darkened by a `percentage`.
    ///
    public func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage))
    }

    /// Adjusts a colour by a `percentage`.
    ///
    /// Lightening → positive percentage
    ///
    /// Darkening → negative percentage
    ///
    /// - Parameters:
    ///     - percentage: the amount to either lighten or darken a colour by.
    ///
    /// - Returns: A colour either lightened or darkened by a `percentage`.
    ///
    public func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    /************************************************/

    static func dcNightBlueColor() -> UIColor {
        return UIColor(hex: 0x172943)
    }

    static func dcBaselineBlueColor() -> UIColor {
        return UIColor(hex: 0x3B5998)
    }

    static func dcSkyBlueColor() -> UIColor {
        return UIColor(hex: 0x81CAF5)
    }

    static func dcLightBlue1Color() -> UIColor {
        return UIColor(hex: 0xF3FAFE)
    }

    static func dcLightBlue2Color() -> UIColor {
        return UIColor(hex: 0xE6F4FB)
    }

    static func dcLightOrangeColor() -> UIColor {
        return UIColor(hex: 0xFF9900)
    }

    static func dcMiddleGrayColor() -> UIColor {
        return UIColor(hex: 0x999999)
    }

    static func dcLightGrayColor() -> UIColor {
        return UIColor(hex: 0xEEEEEE)
    }

    static func dcDarkRedColor() -> UIColor {
        return UIColor(hex: 0xD54A61)
    }
    static func dcVioletColor() -> UIColor {
        return UIColor(hex: 0x525DA0)
    }

    static func dcTopSkyBlueColor() -> UIColor {
        return UIColor(hex: 0x60B5EA)
    }

    static func dcOrangeColor() -> UIColor {
        return UIColor(hex: 0xFF9900)
    }

    static func dcRedColor() -> UIColor {
        return UIColor(hex: 0xD7485F)
    }

    static func dcWhiteColor() -> UIColor {
        return UIColor(hex: 0xFFFFFF)
    }

    static func dcTransparencyBlueColor() -> UIColor {
        return UIColor(transparencyWithHex: 0x1e5bc6)
    }

    static func dcBlueColor() -> UIColor {
        return UIColor(hex: 0x0092D0)
    }

    static func dcGreenColor() -> UIColor {
        return UIColor(hex: 0x99CC00)
    }

    static func dcBlueGrayColor() -> UIColor {
        return UIColor(hex: 0xDAEBF6)
    }

    static func dcLightBlueGrayColor() -> UIColor {
        return UIColor(hex: 0xE7F5FD)
    }
}
