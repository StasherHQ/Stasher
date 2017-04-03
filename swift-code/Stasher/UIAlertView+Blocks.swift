//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  UIAlertView+Blocks.swift
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
typealias UIAlertViewBlock = (_ alertView: UIAlertView) -> Void
typealias UIAlertViewCompletionBlock = (_ alertView: UIAlertView, _ buttonIndex: Int) -> Void
extension UIAlertView {
    class func show(withTitle title: String, message: String, style: UIAlertViewStyle, cancelButtonTitle: String, otherButtonTitles: [Any], tap tapBlock: UIAlertViewCompletionBlock) -> UIAlertView {
        var firstObject: String = otherButtonTitles.count ? otherButtonTitles[0] : nil
        var alertView: UIAlertView? = self.init(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: firstObject)
        alertView?.alertViewStyle = style
        if otherButtonTitles.count > 1 {
            for buttonTitle: String in otherButtonTitles[NSRange(location: 1, length: otherButtonTitles.count - 1).location..<NSRange(location: 1, length: otherButtonTitles.count - 1).location + NSRange(location: 1, length: otherButtonTitles.count - 1).length] {
                alertView?.addButton(withTitle: buttonTitle)
            }
        }
        if tapBlock {
            alertView?.tapBlock = tapBlock
        }
        alertView?.show()
#if !__has_feature(objc_arc)
        return alertView!
#else
        return alertView!
#endif
    }

    class func show(withTitle title: String, message: String, cancelButtonTitle: String, otherButtonTitles: [Any], tap tapBlock: UIAlertViewCompletionBlock) -> UIAlertView {
        return self.show(withTitle: title, message: message, style: .default, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: otherButtonTitles, tap: tapBlock)
    }
    var tapBlock = UIAlertViewCompletionBlock()
    var willDismissBlock = UIAlertViewCompletionBlock()
    var didDismissBlock = UIAlertViewCompletionBlock()
    var willPresentBlock = UIAlertViewBlock()
    var didPresentBlock = UIAlertViewBlock()
    var cancelBlock = UIAlertViewBlock()
    var shouldEnableFirstOtherButtonBlock: ((_ alertView: UIAlertView) -> Bool)? = nil

// MARK: -

    func _checkDelegate() {
        if delegate != (self as? UIAlertViewDelegate) {
            objc_setAssociatedObject(self, UIAlertViewOriginalDelegateKey, delegate, OBJC_ASSOCIATION_ASSIGN)
            delegate = (self as? UIAlertViewDelegate)
        }
    }

    func tapBlock() -> UIAlertViewCompletionBlock {
        return objc_getAssociatedObject(self, UIAlertViewTapBlockKey)
    }

    func setTap(_ tapBlock: UIAlertViewCompletionBlock) {
        _checkDelegate()
        objc_setAssociatedObject(self, UIAlertViewTapBlockKey, tapBlock, OBJC_ASSOCIATION_COPY)
    }

    func willDismissBlock() -> UIAlertViewCompletionBlock {
        return objc_getAssociatedObject(self, UIAlertViewWillDismissBlockKey)
    }

    func setWillDismiss(_ willDismissBlock: UIAlertViewCompletionBlock) {
        _checkDelegate()
        objc_setAssociatedObject(self, UIAlertViewWillDismissBlockKey, willDismissBlock, OBJC_ASSOCIATION_COPY)
    }

    func didDismissBlock() -> UIAlertViewCompletionBlock {
        return objc_getAssociatedObject(self, UIAlertViewDidDismissBlockKey)
    }

    func setDidDismiss(_ didDismissBlock: UIAlertViewCompletionBlock) {
        _checkDelegate()
        objc_setAssociatedObject(self, UIAlertViewDidDismissBlockKey, didDismissBlock, OBJC_ASSOCIATION_COPY)
    }

    func willPresentBlock() -> UIAlertViewBlock {
        return objc_getAssociatedObject(self, UIAlertViewWillPresentBlockKey)
    }

    func setWillPresent(_ willPresentBlock: UIAlertViewBlock) {
        _checkDelegate()
        objc_setAssociatedObject(self, UIAlertViewWillPresentBlockKey, willPresentBlock, OBJC_ASSOCIATION_COPY)
    }

    func didPresentBlock() -> UIAlertViewBlock {
        return objc_getAssociatedObject(self, UIAlertViewDidPresentBlockKey)
    }

    func setDidPresent(_ didPresentBlock: UIAlertViewBlock) {
        _checkDelegate()
        objc_setAssociatedObject(self, UIAlertViewDidPresentBlockKey, didPresentBlock, OBJC_ASSOCIATION_COPY)
    }

    func cancelBlock() -> UIAlertViewBlock {
        return objc_getAssociatedObject(self, UIAlertViewCancelBlockKey)
    }

    func setCancel(_ cancelBlock: UIAlertViewBlock) {
        _checkDelegate()
        objc_setAssociatedObject(self, UIAlertViewCancelBlockKey, cancelBlock, OBJC_ASSOCIATION_COPY)
    }

    func setShouldEnableFirstOtherButtonBlock(_ shouldEnableFirstOtherButtonBlock: @escaping (_ alertView: UIAlertView) -> Bool) {
        _checkDelegate()
        objc_setAssociatedObject(self, UIAlertViewShouldEnableFirstOtherButtonBlockKey, shouldEnableFirstOtherButtonBlock, OBJC_ASSOCIATION_COPY)
    }

    func shouldEnableFirstOtherButtonBlock() -> @escaping (_ alertView: UIAlertView) -> Bool {
        return objc_getAssociatedObject(self, UIAlertViewShouldEnableFirstOtherButtonBlockKey)
    }
// MARK: - UIAlertViewDelegate

    func willPresentAlertView(_ alertView: UIAlertView) {
        var block: UIAlertViewBlock = alertView.willPresentBlock()
        if block {
            block(alertView)
        }
        var originalDelegate: Any? = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey)
        if originalDelegate && originalDelegate?.responds(to: #selector(self.willPresentAlertView)) {
            originalDelegate?.willPresentAlertView(alertView)
        }
    }

    func didPresentAlertView(_ alertView: UIAlertView) {
        var block: UIAlertViewBlock = alertView.didPresentBlock()
        if block {
            block(alertView)
        }
        var originalDelegate: Any? = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey)
        if originalDelegate && originalDelegate?.responds(to: #selector(self.didPresentAlertView)) {
            originalDelegate?.didPresentAlertView(alertView)
        }
    }

    func alertViewCancel(_ alertView: UIAlertView) {
        var block: UIAlertViewBlock = alertView.cancelBlock()
        if block {
            block(alertView)
        }
        var originalDelegate: Any? = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey)
        if originalDelegate && originalDelegate?.responds(to: #selector(self.alertViewCancel)) {
            originalDelegate?.alertViewCancel(alertView)
        }
    }

    func alertView(_ alertView: UIAlertView, clickedButtonat buttonIndex: Int) {
        var completion: UIAlertViewCompletionBlock = alertView.tapBlock()
        if completion {
            completion(alertView, buttonIndex)
        }
        var originalDelegate: Any? = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey)
        if originalDelegate && originalDelegate?.responds(to: Selector("alertView:clickedButtonAtIndex:")) {
            originalDelegate?.alertView(alertView, clickedButtonat: buttonIndex)
        }
    }

    func alertView(_ alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        var completion: UIAlertViewCompletionBlock = alertView.willDismissBlock()
        if completion {
            completion(alertView, buttonIndex)
        }
        var originalDelegate: Any? = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey)
        if originalDelegate && originalDelegate?.responds(to: Selector("alertView:willDismissWithButtonIndex:")) {
            originalDelegate?.alertView(alertView, willDismissWithButtonIndex: buttonIndex)
        }
    }

    func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        var completion: UIAlertViewCompletionBlock = alertView.didDismissBlock()
        if completion {
            completion(alertView, buttonIndex)
        }
        var originalDelegate: Any? = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey)
        if originalDelegate && originalDelegate?.responds(to: Selector("alertView:didDismissWithButtonIndex:")) {
            originalDelegate?.alertView(alertView, didDismissWithButtonIndex: buttonIndex)
        }
    }

    func alertViewShouldEnableFirstOtherButton(_ alertView: UIAlertView) -> Bool {
        var shouldEnableFirstOtherButtonBlock: ((_ alertView: UIAlertView) -> Bool)? = alertView.shouldEnableFirstOtherButtonBlock()
        if shouldEnableFirstOtherButtonBlock != nil {
            return shouldEnableFirstOtherButtonBlock(alertView)
        }
        var originalDelegate: Any? = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey)
        if originalDelegate && originalDelegate?.responds(to: #selector(self.alertViewShouldEnableFirstOtherButton)) {
            return originalDelegate?.alertViewShouldEnableFirstOtherButton(alertView)!
        }
        return true
    }
}
//********Example*******//
/**
[UIAlertView showWithTitle:@"Drink Selection"
                   message:@"Choose a refreshing beverage"
         cancelButtonTitle:@"Cancel"
         otherButtonTitles:@[@"Beer", @"Wine"]
                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                      if (buttonIndex == [alertView cancelButtonIndex]) {
                          NSLog(@"Cancelled");
                      } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Beer"]) {
                          NSLog(@"Have a cold beer");
                      } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Wine"]) {
                          NSLog(@"Have a glass of chardonnay");
                      }
                  }];
**/
import ObjectiveC
let UIAlertViewOriginalDelegateKey = UIAlertViewOriginalDelegateKey
let UIAlertViewTapBlockKey = UIAlertViewTapBlockKey
let UIAlertViewWillPresentBlockKey = UIAlertViewWillPresentBlockKey
let UIAlertViewDidPresentBlockKey = UIAlertViewDidPresentBlockKey
let UIAlertViewWillDismissBlockKey = UIAlertViewWillDismissBlockKey
let UIAlertViewDidDismissBlockKey = UIAlertViewDidDismissBlockKey
let UIAlertViewCancelBlockKey = UIAlertViewCancelBlockKey
let UIAlertViewShouldEnableFirstOtherButtonBlockKey = UIAlertViewShouldEnableFirstOtherButtonBlockKey