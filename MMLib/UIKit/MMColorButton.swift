//
//  MMColorButton.swift
//  Mikoto
//
//  Created by 丁帅 on 15/4/7.
//  Copyright (c) 2015年 m_mikoto. All rights reserved.
//
//****************************************************************************************
//  Custom color Button with real time xib
//  LAST UPDATE 2015-7-28：add solid line border or cut line border
//****************************************************************************************
//

import UIKit
@IBDesignable class MMColorButton: UIButton {
    /// nomal background color
    @IBInspectable var normalColor: UIColor = UIColor.clearColor() {
        didSet{
            self.setNeedsDisplay()
        }
    }
    /// highlight background color
    @IBInspectable var highlightColor: UIColor? {
        didSet{
            self.setNeedsDisplay()
        }
    }
    /// show solid line border or cut line border
    @IBInspectable var isShowCutLine : Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /// solid line border color
    @IBInspectable var borderColor : UIColor = UIColor(colorCode: 0x999999) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /// cut line border color, use borderColor if cutLineBorderColor is nil
    @IBInspectable var cutLineBorderColor : UIColor? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /// border line width
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /// cut line solid part length
    @IBInspectable var lineSolidLength : CGFloat = 3 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /// cut line cut part length
    @IBInspectable var lineCutLength : CGFloat = 2 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /// The radius to use when drawing rounded corners for the layer’s background. Animatable.
    @IBInspectable var radius : CGFloat = 0 {
        didSet {
            if radius > 0 {
                self.layer.cornerRadius = radius
            }
            self.setNeedsDisplay()
        }
    }
    
    override var highlighted: Bool {
        didSet {
            borderColor = borderColor.colorWithAlphaComponent(highlighted ? 0.5 : 1)
            cutLineBorderColor = cutLineBorderColor?.colorWithAlphaComponent(highlighted ? 0.5 : 1)
        }
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, (isShowCutLine && cutLineBorderColor != nil) ? cutLineBorderColor!.CGColor : borderColor.CGColor)
        CGContextSetFillColorWithColor(context, (highlighted && highlightColor != nil) ? highlightColor!.CGColor : normalColor.CGColor)
        CGContextSetLineWidth(context, borderWidth)
        if isShowCutLine {
            CGContextSetLineDash(context, 0, [lineSolidLength, lineCutLength], 2)
        }
        CGContextMoveToPoint(context, 0, radius)
        CGContextAddArcToPoint(context, 0, 0, radius, 0, radius)
        CGContextAddLineToPoint(context, self.width-radius, 0)
        CGContextAddArcToPoint(context, self.width, 0, self.width, radius, radius)
        CGContextAddLineToPoint(context, self.width, self.height-radius)
        CGContextAddArcToPoint(context, self.width, self.height, self.width-radius, self.height, radius)
        CGContextAddLineToPoint(context, radius, self.height)
        CGContextAddArcToPoint(context, 0, self.height, 0, self.height-radius, radius)
        CGContextClosePath(context)
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForInterfaceBuilder() {
    }
    
    convenience init(normalColor nor: UIColor, highlightColor high: UIColor?) {
        self.init(frame:CGRectZero)
        self.normalColor = nor
        self.highlightColor = high
    }
    
    //    MARK: - shark animation
    func shark(shark: Bool) {
        if shark {
            animatable = true
            animateStepIndex = 0
            sharkAnimate()
        } else {
            animatable = false
        }
    }
    
    private var animatable = false
    private let animateStepRadius : [CGFloat] =  [0.03, -0.024, 0.015, -0.02]
    private let animateStepDuring : [NSTimeInterval] = [0.05, 0.03, 0.04, 0.045]
    private var animateStepIndex = 0 {
        didSet {
            animateStepIndex = animateStepIndex > 3 ? 0 : animateStepIndex
        }
    }
    
    private func sharkAnimate() {
        if animatable {
            let trans =  CATransform3DMakeRotation(animateStepRadius[animateStepIndex], 0, 0, 1)
            let basicAnimation = CABasicAnimation(keyPath: "transform")
            basicAnimation.duration = animateStepDuring[animateStepIndex]
            basicAnimation.toValue = NSValue(CATransform3D: trans)
            basicAnimation.delegate = self
            self.layer.addAnimation(basicAnimation, forKey: nil)
        }
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if let transform = anim as? CABasicAnimation where transform.keyPath == "transform" {
            animateStepIndex++
            self.sharkAnimate()
        }
    }
}
