//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  UIFont+STFont.swift
//  Stasher
//
//  Created by bhushan on 10/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
extension UIFont {
    class func fontGothamRounded(withSize size: CGFloat) -> UIFont {
        if IS_STANDARD_IPHONE_6 {
            return UIFont(name: "Gotham Rounded", size: CGFloat(size + 4))!
        }
        return UIFont(name: "Gotham Rounded", size: CGFloat(size + 2))!
    }

    class func fontGothamRoundedBook(withSize size: CGFloat) -> UIFont {
        if IS_STANDARD_IPHONE_6 {
            return UIFont(name: "GothamRounded-Book", size: CGFloat(size + 4))!
        }
        return UIFont(name: "GothamRounded-Book", size: CGFloat(size + 2))!
    }

    class func fontGothamRoundedBold(withSize size: CGFloat) -> UIFont {
        if IS_STANDARD_IPHONE_6 {
            return UIFont(name: "GothamRounded-Bold", size: CGFloat(size + 4))!
        }
        return UIFont(name: "GothamRounded-Bold", size: CGFloat(size + 2))!
    }

    class func fontGothamRoundedMedium(withSize size: CGFloat) -> UIFont {
        if IS_STANDARD_IPHONE_6 {
            return UIFont(name: "GothamRounded-Medium", size: CGFloat(size + 4))!
        }
        return UIFont(name: "GothamRounded-Medium", size: CGFloat(size + 2))!
    }

    convenience init() {
        return UIFont(name: "GothamRounded-Medium", size: CGFloat(18.0))!
    }

    convenience init() {
        if IS_STANDARD_IPHONE_6 {
            return UIFont(name: "GothamRounded-Medium", size: CGFloat(10.0 + 4.0))!
        }
        return UIFont(name: "GothamRounded-Medium", size: CGFloat(10.0 + 2.0))!
    }

    convenience init(size: CGFloat) {
        if IS_STANDARD_IPHONE_6 {
            return UIFont(name: "GothamRounded-Medium", size: CGFloat(size + 4))!
        }
        return UIFont(name: "GothamRounded-Medium", size: CGFloat(size + 2))!
    }

    convenience init() {
        return UIFont(name: "GothamRounded-Book", size: CGFloat(18.0))!
    }

    convenience init(for size: CGFloat) {
        if IS_STANDARD_IPHONE_6 {
            return UIFont(name: "GothamRounded-LightItalic", size: CGFloat(size + 4))!
        }
        return UIFont(name: "GothamRounded-LightItalic", size: CGFloat(size + 2))!
    }

    convenience init(for size: CGFloat) {
        if IS_STANDARD_IPHONE_6 {
            return UIFont(name: "GothamRounded-Book", size: CGFloat(size + 4))!
        }
        return UIFont(name: "GothamRounded-Book", size: CGFloat(size + 2))!
    }

    /****************************************************
     Family name: Gotham Rounded
     Font name: GothamRounded-BookItalic
     Font name: GothamRounded-MediumItalic
     Font name: GothamRounded-BoldItalic
     Font name: GothamRounded-Light
     Font name: GothamRounded-Medium
     Font name: GothamRounded-Bold
     Font name: GothamRounded-LightItalic
     Font name: GothamRounded-Book
     ***************************************************/

}