//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STNoInternetView.swift
//  Stasher
//
//  Created by Bhushan on 23/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STNoInternetView: UIView {

    init(defaultSizeandSuperView thisSuperView: UIView) {
        super.init(frame: CGRect(x: CGFloat(0.0), y: CGFloat(thisSuperView.frame.size.height - 30.0), width: CGFloat(thisSuperView.frame.size.width), height: CGFloat(30.0)))
        
        backgroundColor = UIColor.gray
        var labl = UILabel(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(thisSuperView.frame.size.width), height: CGFloat(30.0)))
        labl.textAlignment = .center
        labl.text = "No Internet Connection"
        labl.textColor = UIColor.white
        labl.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
        addSubview(labl)
        thisSuperView.addSubview(self, withAnimation: true)
        performSelector(#selector(self.removeSelfFromSuperView), withObject: nil, afterDelay: 1.5)
        alpha = 0.7
    
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    - (void)drawRect:(CGRect)rect {
        // Drawing code
    }
    */

    func removeSelfFromSuperView() {
        remove(fromSuperviewwithAnimation: true)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override init() {
        super.init()
    }
}