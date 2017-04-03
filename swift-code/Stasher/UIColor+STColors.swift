//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  UIColor+STColors.swift
//  Stasher
//
//  Created by bhushan on 08/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
extension UIColor {
    class func fromHexString(_ hexString: String) -> UIColor {
        var cleanString = hexString.replacingOccurrences(of: "#", with: "")
        if (cleanString.characters.count ?? 0) == 3 {
            cleanString = "\(cleanString as NSString).substring(with: NSRange(location: 0, length: 1))\(cleanString as NSString).substring(with: NSRange(location: 0, length: 1))\(cleanString as NSString).substring(with: NSRange(location: 1, length: 1))\(cleanString as NSString).substring(with: NSRange(location: 1, length: 1))\(cleanString as NSString).substring(with: NSRange(location: 2, length: 1))\(cleanString as NSString).substring(with: NSRange(location: 2, length: 1))"
        }
        if (cleanString.characters.count ?? 0) == 6 {
            cleanString = cleanString + ("ff")
        }
        var baseValue: UInt
        Scanner(string: cleanString).scanHexInt32(baseValue)
        var red: Float = ((baseValue >> 24) & 0xff) / 255.0
        var green: Float = ((baseValue >> 16) & 0xff) / 255.0
        var blue: Float = ((baseValue >> 8) & 0xff) / 255.0
        var alpha: Float = ((baseValue >> 0) & 0xff) / 255.0
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }

    class func hexValues(from color: UIColor) -> String {
        if !color {
            return nil
        }
        if color == UIColor.white {
            // Special case, as white doesn't fall into the RGB color space
            return "ffffff"
        }
        var red: CGFloat
        var blue: CGFloat
        var green: CGFloat
        var alpha: CGFloat
        color.getRed(red, green: green, blue: blue, alpha: alpha)
        var redDec = Int(red * 255)
        var greenDec = Int(green * 255)
        var blueDec = Int(blue * 255)
        var returnString = String(format: "%02x%02x%02x", UInt(redDec), UInt(greenDec), UInt(blueDec))
        return returnString
    }

    class func stasherText() -> UIColor {
        return UIColor(red: CGFloat(52.0 / 255), green: CGFloat(52.0 / 255), blue: CGFloat(52.0 / 255), alpha: CGFloat(1.0))
    }

    class func stasherTextFieldPlaceHolder() -> UIColor {
        return UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0))
    }

    class func stasherPopUpBG() -> UIColor {
        return UIColor(red: CGFloat(230.0 / 255), green: CGFloat(230.0 / 255), blue: CGFloat(230.0 / 255), alpha: CGFloat(1.0))
    }

    class func stasherAccountTableRowText() -> UIColor {
        //return [UIColor colorWithRed:231.0f/255 green:230.0f/255 blue:231.0f/255 alpha:1.0f];
        return UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0))
    }

    class func stasherMissionDueProgress() -> UIColor {
        return UIColor(red: CGFloat(245.0 / 255.0), green: CGFloat(204.0 / 255.0), blue: CGFloat(78.0 / 255.0), alpha: CGFloat(1.0))
    }
}