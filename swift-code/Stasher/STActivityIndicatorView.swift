//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STActivityIndicatorView.swift
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STActivityIndicatorView: UIView {

    //0.0 - 1.0
    var anglePer: CGFloat {
        get {
            // TODO: add getter implementation
        }
        set(anglePer) {
            _anglePer = anglePer
            setNeedsDisplay()
        }
    }
    var timer: Timer?
    var bgVC: STActivityBGViewController?

    //default is 1.0f
    var lineWidth: CGFloat = 0.0
    //default is [UIColor lightGrayColor]
    var lineColor: UIColor?
    private(set) var isAnimating: Bool = false
    //use this to init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
    
    }

    init(defaultSizeandSuperView thisSuperView: UIView) {
        super.init(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(35.0), height: CGFloat(35.0)))
        
        backgroundColor = UIColor.clear
        center = thisSuperView.center
        bgVC = STActivityBGViewController(nibName: "STActivityBGViewController", bundle: Bundle.main)
        bgVC?.view?.addSubview(self)
        bgVC?.view?.frame = UIApplication.shared.keyWindow?.bounds
        UIApplication.shared.keyWindow?.addSubview(bgVC?.view)
        //[thisSuperView addSubview:bgVC];
    
    }

    func startAnimation() {
        if isAnimating() {
            stopAnimation()
            layer.removeAllAnimations()
        }
        isAnimating = true
        anglePer = 0
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.drawPathAnimation), userInfo: nil, repeats: true)
        RunLoop.current.addTimer(timer, forMode: NSRunLoopCommonModes)
    }

    func stopAnimation() {
        isAnimating = false
        if timer?.isValid() {
            timer?.invalidate()
            timer = nil
        }
        stopRotateAnimation()
    }


    override init() {
        super.init()
        
        backgroundColor = UIColor.clear
    
    }

    func drawPathAnimation(_ timer: Timer) {
        anglePer += 0.03
        if anglePer >= 1 {
            anglePer = 1
            timer.invalidate()
            self.timer = nil
            startRotateAnimation()
        }
    }

    func startRotateAnimation() {
        var animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = (0)
        animation.toValue = (2 * .pi)
        animation.duration = 1.0
        animation.repeatCount = INT_MAX
        layer.addAnimation(animation, forKey: "keyFrameAnimation")
    }

    func stopRotateAnimation() {
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            alpha = 0
        }, completion: {(_ finished: Bool) -> Void in
            self.anglePer = 0
            layer.removeAllAnimations()
            alpha = 1
            self.bgVC?.view?.remove(fromSuperviewwithAnimation: true)
        })
    }

    override func draw(_ rect: CGRect) {
        if anglePer <= 0 {
            _anglePer = 0
        }
        var lineWidth: CGFloat = 1.5
        var lineColor = UIColor(red: CGFloat(64.0 / 255.0), green: CGFloat(178.0 / 255.0), blue: CGFloat(241.0 / 255.0), alpha: CGFloat(1.0))
        //[UIColor cyanColor];
        if self.lineWidth {
            lineWidth = self.lineWidth
        }
        if self.lineColor {
            lineColor = self.lineColor
        }
        var context: CGContext? = UIGraphicsGetCurrentContext()
        context.setLineWidth(lineWidth)
        context.setStrokeColor(lineColor.cgColor)
        context.addArc(center: CGPoint(x: CGFloat(bounds.midX), y: CGFloat(bounds.midY)), radius: CGFloat(bounds.width / 2 - lineWidth), startAngle: CGFloat(ANGLE(120)), endAngle: CGFloat(ANGLE(120) + ANGLE(330) * anglePer), clockwise: 0)
        context.strokePath()
    }
}
func ANGLE(a: Any) -> Any {
    return 2 * .pi / 360 * a
}