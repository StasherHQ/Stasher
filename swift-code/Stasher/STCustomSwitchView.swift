//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STCustomSwitchView.swift
//  Stasher
//
//  Created by bhushan on 21/01/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STCustomSwitchView: UIView {

    @IBOutlet var buttonFirst: UIButton!
    @IBOutlet var buttonSecond: UIButton!
    @IBOutlet var imgViewGreen: UIImageView!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    - (void)drawRect:(CGRect)rect {
        // Drawing code
    }
    */

    @IBAction func buttonFirstPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreen.center = buttonFirst.center
        })
    }

    @IBAction func buttonSecondPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreen.center = buttonSecond.center
        })
    }
}