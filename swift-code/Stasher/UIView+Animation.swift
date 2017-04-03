//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  UIView+Animation.swift
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
extension UIView {
    func addSubview(_ view: UIView, withAnimation shouldAnimate: Bool) {
        addSubview(view)
        if shouldAnimate {
            view.alpha = 0.0
            UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
                view.alpha = 1.0
            })
        }
    }

    func remove(fromSuperviewwithAnimation shouldAnimate: Bool) {
        if shouldAnimate {
            alpha = 1.0
            UIView.animate(withDuration: kRemoveSubviewAnimationDuration, animations: {() -> Void in
                self.alpha = 0.0
            }, completion: {(_ finished: Bool) -> Void in
                if finished {
                    self.removeFromSuperview()
                }
            })
        }
        else {
            removeFromSuperview()
        }
    }

    func setHidden(animated hide: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {() -> Void in
            UIView.setAnimationCurve(.easeInOut)
            if hide {
                alpha = 0
            }
            else {
                isHidden = false
                alpha = 1
            }
        }, completion: {(_ b: Bool) -> Void in
            if hide {
                isHidden = true
            }
        })
    }

    func addPopUpOnKeyWindow() {
        frame = UIApplication.shared.keyWindow?.frame
        UIApplication.shared.keyWindow?.addSubview(self, withAnimation: true)
    }

    func removePopUpOnKeyWindow() {
        remove(fromSuperviewwithAnimation: true)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    - (void)drawRect:(CGRect)rect {
        // Drawing code
    }
    */

}