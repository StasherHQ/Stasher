//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  DACircularProgressView.swift
//  DACircularProgress
//
//  Created by Daniel Amitay on 2/6/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//
import UIKit
class DACircularProgressView: UIView {
    var ui_APPEARANCE_SELECTOR: UIColor?
    var ui_APPEARANCE_SELECTOR: UIColor?
    var ui_APPEARANCE_SELECTOR = NSInteger roundedCorners()
    // Can not use BOOL with UI_APPEARANCE_SELECTOR :-(
    var ui_APPEARANCE_SELECTOR = CGFloat thicknessRatio()
    var ui_APPEARANCE_SELECTOR = NSInteger clockwiseProgress()
    // Can not use BOOL with UI_APPEARANCE_SELECTOR :-(
    var progress: CGFloat = 0.0
    var ui_APPEARANCE_SELECTOR = CGFloat indeterminateDuration()
    var ui_APPEARANCE_SELECTOR = NSInteger indeterminate()
    // Can not use BOOL with UI_APPEARANCE_SELECTOR :-(

    func setProgress(_ progress: CGFloat, animated: Bool) {
        setProgress(progress, animated: animated, initialDelay: 0.0)
    }

    func setProgress(_ progress: CGFloat, animated: Bool, initialDelay: CFTimeInterval) {
        layer.removeAnimation(forKey: "indeterminateAnimation")
        circularProgressLayer.removeAnimation(forKey: "progress")
        var pinnedProgress: CGFloat = min(max(progress, 0.0), 1.0)
        if animated {
            var animation = CABasicAnimation(keyPath: "progress")
            animation.duration = fabs(self.progress - pinnedProgress)
            // Same duration as UIProgressView animation
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.fillMode = kCAFillModeForwards
            animation.fromValue = Int(self.progress)
            animation.toValue = Int(pinnedProgress)
            animation.beginTime = CACurrentMediaTime() + initialDelay
            animation.delegate = self
            circularProgressLayer.addAnimation(animation, forKey: "progress")
        }
        else {
            circularProgressLayer.setNeedsDisplay()
            circularProgressLayer.progress = pinnedProgress
        }
    }


    class func initialize() {
        if self == DACircularProgressView.self {
            var circularProgressViewAppearance = DACircularProgressView.appearance()
            circularProgressViewAppearance.trackTintColor = UIColor.white.withAlphaComponent(0.3)
            circularProgressViewAppearance.progressTintColor = UIColor.white
            circularProgressViewAppearance.backgroundColor = UIColor.clear
            circularProgressViewAppearance.thicknessRatio = 0.3
            circularProgressViewAppearance.roundedCorners = false
            circularProgressViewAppearance.clockwiseProgress = true
            circularProgressViewAppearance.indeterminateDuration = 2.0
            circularProgressViewAppearance.indeterminate = false
        }
    }

    class func layerClass() -> AnyClass {
        return DACircularProgressLayer.self
    }

    func circularProgressLayer() -> DACircularProgressLayer {
        return (layer as? DACircularProgressLayer)!
    }

    override init() {
        return super.init(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(40.0), height: CGFloat(40.0)))
    }

    override func didMoveToWindow() {
        var windowContentsScale: CGFloat? = window?.screen?.scale()
        circularProgressLayer().contentsScale = windowContentsScale
        circularProgressLayer().setNeedsDisplay()
    }
// MARK: - Progress

    func progress() -> CGFloat {
        return circularProgressLayer().progress
    }

    func setProgress(_ progress: CGFloat) {
        setProgress(progress, animated: false)
    }

    func animationDidStop(_ animation: CAAnimation, finished flag: Bool) {
        var pinnedProgressNumber = (animation.value(forKey: "toValue") as? NSNumber)
        circularProgressLayer().progress = CFloat(pinnedProgressNumber)
    }
// MARK: - UIAppearance methods

    func trackTintColor() -> UIColor {
        return circularProgressLayer().trackTintColor!
    }

    func setTrackTintColor(_ trackTintColor: UIColor) {
        circularProgressLayer().trackTintColor = trackTintColor
        circularProgressLayer().setNeedsDisplay()
    }

    func progressTintColor() -> UIColor {
        return circularProgressLayer().progressTintColor!
    }

    func setProgressTintColor(_ progressTintColor: UIColor) {
        circularProgressLayer().progressTintColor = progressTintColor
        circularProgressLayer().setNeedsDisplay()
    }

    func roundedCorners() -> Int {
        return roundedCorners()
    }

    func setRoundedCorners(_ roundedCorners: Int) {
        circularProgressLayer().roundedCorners = roundedCorners
        circularProgressLayer().setNeedsDisplay()
    }

    func thicknessRatio() -> CGFloat {
        return circularProgressLayer().thicknessRatio()
    }

    func setThicknessRatio(_ thicknessRatio: CGFloat) {
        circularProgressLayer().thicknessRatio = min(max(thicknessRatio, 0.0), 1.0)
        circularProgressLayer().setNeedsDisplay()
    }

    func indeterminate() -> Int {
        var spinAnimation: CAAnimation? = layer.animation(forKey: "indeterminateAnimation")
        return (spinAnimation == nil ? 0 : 1)
    }

    func setIndeterminate(_ indeterminate: Int) {
        if indeterminate != 0 {
            if !self.indeterminate() {
                var spinAnimation = CABasicAnimation(keyPath: "transform.rotation")
                spinAnimation.byValue = Int(indeterminate > 0 ? 2.0 * .pi : -2.0 * .pi)
                spinAnimation.duration = indeterminateDuration
                spinAnimation.repeatCount = HUGE_VALF
                layer.addAnimation(spinAnimation, forKey: "indeterminateAnimation")
            }
        }
        else {
            layer.removeAnimation(forKey: "indeterminateAnimation")
        }
    }

    func clockwiseProgress() -> Int {
        return circularProgressLayer().clockwiseProgress()
    }

    func setClockwiseProgress(_ clockwiseProgres: Int) {
        circularProgressLayer().clockwiseProgress = clockwiseProgres
        circularProgressLayer().setNeedsDisplay()
    }
}
import QuartzCore
class DACircularProgressLayer: CALayer {
    var trackTintColor: UIColor?
    var progressTintColor: UIColor?
    var roundedCorners: Int = 0
    var thicknessRatio: CGFloat = 0.0
    var progress: CGFloat = 0.0
    var clockwiseProgress: Int = 0


    class func needsDisplay(forKey key: String) -> Bool {
        if (key == "progress") {
            return true
        }
        else {
            return super.needsDisplay(forKey: key)
        }
    }

    override func draw(inContext context: CGContext?) {
        var rect: CGRect = bounds
        var centerPoint = CGPoint(x: CGFloat(rect.size.width / 2.0), y: CGFloat(rect.size.height / 2.0))
        var radius: CGFloat = min(rect.size.height, rect.size.width) / 2.0
        var clockwise: Bool = (clockwiseProgress() != 0)
        var progress: CGFloat = min(self.progress, 1.0 - FLT_EPSILON)
        var radians: CGFloat = 0
        if clockwise {
            radians = Float((progress * 2.0 * .pi) - M_PI_2)
        }
        else {
            radians = Float(3 * M_PI_2 - (progress * 2.0 * .pi))
        }
        context.setFillColor(trackTintColor?.cgColor)
        var trackPath: CGMutablePathRef = CGMutablePath()
        trackPath.move(to: CGPoint(x: CGFloat(centerPoint.x), y: CGFloat(centerPoint.y)), transform: .identity)
        trackPath.addArc(center: CGPoint(x: CGFloat(centerPoint.x), y: CGFloat(centerPoint.y)), radius: radius, startAngle: CGFloat(Float(2.0 * .pi)), endAngle: CGFloat(0.0), clockwise: true, transform: .identity)
        CGPathCloseSubpath(trackPath)
        context.addPath(trackPath)
        context.fillPath()
        if progress > 0.0 {
            context.setFillColor(progressTintColor?.cgColor)
            var progressPath: CGMutablePathRef = CGMutablePath()
            progressPath.move(to: CGPoint(x: CGFloat(centerPoint.x), y: CGFloat(centerPoint.y)), transform: .identity)
            progressPath.addArc(center: CGPoint(x: CGFloat(centerPoint.x), y: CGFloat(centerPoint.y)), radius: radius, startAngle: CGFloat(Float(3.0 * M_PI_2)), endAngle: radians, clockwise: !clockwise, transform: .identity)
            CGPathCloseSubpath(progressPath)
            context.addPath(progressPath)
            context.fillPath()
        }
        if progress > 0.0 && roundedCorners() {
            var pathWidth: CGFloat = radius * thicknessRatio()
            var xOffset: CGFloat = radius * (1.0 + (1.0 - (thicknessRatio() / 2.0)) * cosf(radians))
            var yOffset: CGFloat = radius * (1.0 + (1.0 - (thicknessRatio() / 2.0)) * sinf(radians))
            var endPoint = CGPoint(x: xOffset, y: yOffset)
            var startEllipseRect = CGRect()
                startEllipseRect.origin.x = centerPoint.x - pathWidth / 2.0
                startEllipseRect.origin.y = 0.0
                startEllipseRect.size.width = pathWidth
                startEllipseRect.size.height = pathWidth
            context.addEllipse(in: startEllipseRect)
            context.fillPath()
            var endEllipseRect = CGRect()
                endEllipseRect.origin.x = endPoint.x - pathWidth / 2.0
                endEllipseRect.origin.y = endPoint.y - pathWidth / 2.0
                endEllipseRect.size.width = pathWidth
                endEllipseRect.size.height = pathWidth
            context.addEllipse(in: endEllipseRect)
            context.fillPath()
        }
        CGContextSetBlendMode(context, kCGBlendModeClear)
        var innerRadius: CGFloat = radius * (1.0 - thicknessRatio())
        var clearRect = CGRect()
            clearRect.origin.x = centerPoint.x - innerRadius
            clearRect.origin.y = centerPoint.y - innerRadius
            clearRect.size.width = innerRadius * 2.0
            clearRect.size.height = innerRadius * 2.0
        context.addEllipse(in: clearRect)
        context.fillPath()
    }
}