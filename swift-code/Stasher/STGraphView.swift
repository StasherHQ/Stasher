//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STGraphView.swift
//  Stasher
//
//  Created by bhushan on 01/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STGraphView: UIView {

    var data = [Any]()
    var min: CGFloat = 0.0
    var max: CGFloat = 0.0
    var initialPath: CGMutablePathRef = nil
    var newPath: CGMutablePathRef = nil
    // Block definition for getting a label for a set index (use case: date, units,...)
    typealias FSLabelForIndexGetter = (_ index: Int) -> String
        // Same as above, but for the value (for adding a currency, or a unit symbol for example)
typealias FSLabelForValueGetter = (_ value: CGFloat) -> String
    // Number of visible step in the chart
    var gridStep: Int = 0
    // Margin of the chart
    var margin: CGFloat = 0.0
    private(set) var axisWidth: CGFloat = 0.0
    private(set) var axisHeight: CGFloat = 0.0
    // Decoration parameters, let you pick the color of the line as well as the color of the axis
    var axisColor: UIColor?
    var color: UIColor?
    var labelForIndex = FSLabelForIndexGetter()
    var labelForValue = FSLabelForValueGetter()
    // Set the actual data for the chart, and then render it to the view.

    func setChartData(_ chartData: [Any]) {
        _data = [Any](arrayLiteral: chartData)
        gridStep = Int(_data.count)
        _min = MAXFLOAT
        _max = -MAXFLOAT
        for i in 0..<_data.count {
            var number = _data[i]
            if CFloat(number) < _min {
                _min = CFloat(number)
            }
            if CFloat(number) > _max {
                _max = CFloat(number)
            }
        }
        _max = getUpperRoundNumber(_max, forGridStep: gridStep)
        // No data
        if isnan(_max) {
            _max = 1
        }
        strokeChart()
        if labelForValue {
            for i in 0..<gridStep {
                var p = CGPoint(x: margin, y: CGFloat(axisHeight + margin - (i + 1) * axisHeight / gridStep))
                var text: String = labelForValue(_max / gridStep * (i + 1))
                var rect = CGRect(x: margin, y: CGFloat(p.y + 2), width: CGFloat(frame.size.width - margin * 2 - 4.0), height: CGFloat(14))
                var width = text.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: CGFloat(12.0))], context: nil).size.width
                var label = UILabel(frame: CGRect(x: CGFloat(p.x - width - 6), y: CGFloat(p.y - 5), width: CGFloat(width + 2 + 5), height: CGFloat(14)))
                label.text = "$\(text)"
                label.font = UIFont.fontGothamRoundedBold(withSize: 5.95)
                label.textColor = UIColor(red: CGFloat(94.0 / 255), green: CGFloat(94.0 / 255), blue: CGFloat(94.0 / 255), alpha: CGFloat(1.0))
                label.textAlignment = .center
                label.backgroundColor = UIColor.clear
                addSubview(label)
            }
        }
        if labelForIndex {
            var scale: Float = 1.0
            var q = Int(_data.count) / gridStep
            scale = CGFloat(q * gridStep) / CGFloat(_data.count - 1)
            for i in 0..<gridStep - 1 + 1 {
                var itemIndex: Int = q * i
                if itemIndex >= _data.count {
                    itemIndex = _data.count - 1
                }
                var text: String = labelForIndex(itemIndex + 1)
                var p = CGPoint(x: CGFloat(margin + i * (axisWidth / gridStep) * scale), y: CGFloat(axisHeight + margin))
                var label = UILabel(frame: CGRect(x: CGFloat(p.x - 14.0), y: CGFloat(p.y + 2), width: CGFloat(frame.size.width), height: CGFloat(14)))
                label.text = "Day \(text)"
                label.font = UIFont.fontGothamRoundedBold(withSize: 5.0)
                label.textColor = UIColor(red: CGFloat(130.0 / 255), green: CGFloat(130.0 / 255), blue: CGFloat(130.0 / 255), alpha: CGFloat(1.0))
                addSubview(label)
            }
        }
        setNeedsDisplay()
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: CGFloat(231.0 / 255), green: CGFloat(230.0 / 255), blue: CGFloat(231.0 / 255), alpha: CGFloat(1.0))
        setDefaultParameters()
    
    }

    override func draw(_ rect: CGRect) {
        drawGrid()
    }

    func drawGrid() {
        gridStep = Int(_data.count)
        var ctx: CGContext? = UIGraphicsGetCurrentContext()
        UIGraphicsPushContext(ctx)
        ctx.setLineWidth(CGFloat(2))
        ctx.setStrokeColor(axisColor?.cgColor)
        // draw coordinate axis
        ctx.move(to: CGPoint(x: CGFloat(margin + DisplaceMent), y: margin))
        ctx.addLine(to: CGPoint(x: CGFloat(margin + DisplaceMent), y: CGFloat(axisHeight + margin + DisplaceMent)))
        ctx.strokePath()
        ctx.move(to: CGPoint(x: CGFloat(margin + DisplaceMent), y: CGFloat(axisHeight + margin)))
        ctx.addLine(to: CGPoint(x: CGFloat(axisWidth + margin + DisplaceMent), y: CGFloat(axisHeight + margin)))
        ctx.strokePath()
        var scale: Float = 1.0
        var q = Int(_data.count) / gridStep
        scale = CGFloat(q * gridStep) / CGFloat(_data.count - 1)
        // draw grid
        for i in 0..<gridStep {
            ctx.setLineWidth(CGFloat(0.5))
            var point = CGPoint(x: CGFloat((1 + i) * axisWidth / gridStep * scale + margin), y: margin)
            ctx.move(to: CGPoint(x: CGFloat(point.x), y: CGFloat(point.y)))
            ctx.addLine(to: CGPoint(x: CGFloat(point.x), y: CGFloat(4)))
            ctx.strokePath()
            ctx.setLineWidth(CGFloat(2))
            ctx.move(to: CGPoint(x: CGFloat(point.x - 0.5), y: CGFloat(axisHeight + margin)))
            ctx.addLine(to: CGPoint(x: CGFloat(point.x - 0.5), y: CGFloat(axisHeight + margin + DisplaceMent)))
            ctx.strokePath()
        }
        for i in 0..<gridStep {
            ctx.setLineWidth(CGFloat(0.5))
            var point = CGPoint(x: CGFloat(margin + 5), y: CGFloat((axisHeight as? i) / gridStep + margin))
            ctx.move(to: CGPoint(x: CGFloat(point?.x), y: CGFloat(point?.y)))
            ctx.addLine(to: CGPoint(x: CGFloat(axisWidth + margin), y: CGFloat(point?.y)))
            ctx.strokePath()
        }
    }

    func strokeChart() {
        if _data.count == 0 {
            print("Warning: no data provided for the chart")
            return
        }
        var path = UIBezierPath()
        var noPath = UIBezierPath()
        var fill = UIBezierPath()
        var noFill = UIBezierPath()
        var scale: CGFloat = axisHeight / _max
        var first = _data[0]
        for i in 1..<_data.count {
            var last = _data[i - 1]
            var number = _data[i]
            var p1 = CGPoint(x: CGFloat(margin + (i - 1) * (axisWidth / (_data.count - 1))), y: CGFloat(axisHeight + margin - CFloat(last) * scale))
            var p2 = CGPoint(x: CGFloat(margin + i * (axisWidth / (_data.count - 1))), y: CGFloat(axisHeight + margin - CFloat(number) * scale))
            fill.move(to: p1)
            fill.addLine(to: p2)
            fill.addLine(to: CGPoint(x: CGFloat(p2.x), y: CGFloat(axisHeight + margin)))
            fill.addLine(to: CGPoint(x: CGFloat(p1.x), y: CGFloat(axisHeight + margin)))
            noFill.move(to: CGPoint(x: CGFloat(p1.x), y: CGFloat(axisHeight + margin)))
            noFill.addLine(to: CGPoint(x: CGFloat(p2.x), y: CGFloat(axisHeight + margin)))
            noFill.addLine(to: CGPoint(x: CGFloat(p2.x), y: CGFloat(axisHeight + margin)))
            noFill.addLine(to: CGPoint(x: CGFloat(p1.x), y: CGFloat(axisHeight + margin)))
        }
        path.move(to: CGPoint(x: CGFloat(DisplaceMent + 2 + margin), y: CGFloat(axisHeight + margin - CFloat(first) * scale)))
        noPath.move(to: CGPoint(x: margin, y: CGFloat(axisHeight + margin)))
        for i in 1..<_data.count {
            var number = _data[i]
            path.addLine(to: CGPoint(x: CGFloat(margin + i * (axisWidth / (_data.count - 1))), y: CGFloat(axisHeight + margin - CFloat(number) * scale)))
            noPath.addLine(to: CGPoint(x: CGFloat(margin + i * (axisWidth / (_data.count - 1))), y: CGFloat(axisHeight + margin)))
        }
        var fillLayer = CAShapeLayer()
        fillLayer.frame = bounds
        fillLayer.bounds = bounds
        fillLayer.path = fill.cgPath
        fillLayer.strokeColor = nil
        fillLayer.fillColor = UIColor.clear.cgColor
        //[_color colorWithAlphaComponent:0.25].CGColor;
        fillLayer.lineWidth = 0
        fillLayer.lineJoin = kCALineJoinRound
        layer.addSublayer(fillLayer)
        var pathLayer = CAShapeLayer()
        pathLayer.frame = bounds
        pathLayer.bounds = bounds
        pathLayer.path = path.cgPath
        pathLayer.strokeColor = color?.cgColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 1.5
        pathLayer.lineJoin = kCALineJoinRound
        layer.addSublayer(pathLayer)
        var fillAnimation = CABasicAnimation(keyPath: "path")
        fillAnimation.duration = 0.25
        fillAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        fillAnimation.fillMode = kCAFillModeForwards
        fillAnimation.fromValue = (noFill.cgPath as? Any)
        fillAnimation.toValue = (fill.cgPath as? Any)
        fillLayer.addAnimation(fillAnimation, forKey: "path")
        var pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.duration = 1.0
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnimation.fromValue = ((noPath.cgPath) as? Any)
        pathAnimation.toValue = ((path.cgPath) as? Any)
        //[pathLayer addAnimation:pathAnimation forKey:@"path"];
        for i in 0..<_data.count {
            var rect: CGRect
            var number = _data[i]
            //
            if i == 0 {
                rect = CGRect(x: CGFloat(margin + 2 * DisplaceMent + i * (axisWidth / (_data.count - 1)) - 1.2 * margin), y: CGFloat(axisHeight + margin - CFloat(number) * scale - margin), width: CGFloat(10), height: CGFloat(10))
            }
            else {
                rect = CGRect(x: CGFloat(margin + i * (axisWidth / (_data.count - 1)) - 1.2 * margin), y: CGFloat(axisHeight + margin - CFloat(number) * scale - margin), width: CGFloat(10), height: CGFloat(10))
            }
            var circleView = UIView(frame: rect)
            circleView.alpha = 1.0
            circleView.layer.cornerRadius = 6
            circleView.backgroundColor = UIColor(red: CGFloat(247.0 / 255), green: CGFloat(203.0 / 255), blue: CGFloat(73.0 / 255), alpha: CGFloat(1.0))
            circleView.layer.borderColor = UIColor.lightGray.cgColor
            circleView.layer.borderWidth = 0.5
            addSubview(circleView)
            //
        }
    }

    func setDefaultParameters() {
        color = UIColor(red: CGFloat(117.0 / 255), green: CGFloat(185.0 / 255), blue: CGFloat(220.0 / 255), alpha: CGFloat(1.0))
        gridStep = 3
        margin = 5.0
        axisWidth = frame.size.width - 2 * margin
        axisHeight = frame.size.height - 2 * margin
        axisColor = UIColor(red: CGFloat(209.0 / 255), green: CGFloat(209.0 / 255), blue: CGFloat(209.0 / 255), alpha: CGFloat(1.0))
    }

    func getUpperRoundNumber(_ value: CGFloat, forGridStep gridStep: Int) -> CGFloat {
            // We consider a round number the following by 0.5 step instead of true round number (with step of 1)
        var logValue: CGFloat = log10f(value)
        var scale: CGFloat = powf(10, floorf(logValue))
        var n: CGFloat = ceilf(value / scale * 2)
        var tmp = Int(n) % gridStep
        if tmp != 0 {
            n += gridStep - tmp
        }
        return n * scale / 2.0
    }
}
let DisplaceMent = 3.0