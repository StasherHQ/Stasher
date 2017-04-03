//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  NSObject+STSharedCustoms.swift
//  Stasher
//
//  Created by bhushan on 15/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import Foundation
protocol STSharedCustomsDelegate: NSObjectProtocol {
    func rightGestureHandle()
}
class STSharedCustoms: NSObject {

    weak var delegate: STSharedCustomsDelegate? {
        get {
            // TODO: add getter implementation
        }
        set(delegate) {
            self.delegate = delegate
        }
    }

    class func sharedAddGestureInstance(withDelegate delegate: Any) -> STSharedCustoms {
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            if __instance == nil {
                __instance = STSharedCustoms()
            }
        }
        __instance.delegate = delegate
        return __instance
    }

    func addRightSwipeGestureRecognizerToMe() {
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleRightSwipe))
        swipeLeft.numberOfTouchesRequired = 1
        //give required num of touches here ..
        swipeLeft.direction = .right
        swipeLeft.delegate = (self as? Any)
        var vc: UIViewController? = (__instance.delegate as? UIViewController)
        vc?.view?.addGestureRecognizer(swipeLeft)
    }


    func handleRightSwipe(_ recognizer: UISwipeGestureRecognizer) {
        //Do ur code for Push/pop..
        if __instance.delegate.responds(to: #selector(self.rightGestureHandle)) {
            __instance.delegate.rightGestureHandle()
        }
    }
}
var __instance: STSharedCustoms? = nil