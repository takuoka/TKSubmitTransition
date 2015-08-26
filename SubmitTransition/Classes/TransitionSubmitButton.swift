//
//  TransitionSubmitButton.swift
//  SubmitTransition
//
//  Created by Takuya Okamoto on 2015/08/06.
//  Copyright (c) 2015年 Uniface. All rights reserved.
//

import Foundation
import UIKit

public class TKTransitionSubmitButton : UIButton, UIViewControllerTransitioningDelegate {
    
    public var didEndFinishAnimation : (()->())? = nil

    let pink = UIColor(red:0.992157, green: 0.215686, blue: 0.403922, alpha: 1)
    let darkPink = UIColor(red:0.798012, green: 0.171076, blue: 0.321758, alpha: 1)
    let springGoEase = CAMediaTimingFunction(controlPoints: 0.45,-0.36,0.44,0.92)
    let shrinkCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    let expandCurve = CAMediaTimingFunction(controlPoints: 0.95,0.02,1,0.05)
    let shrinkDuration: CFTimeInterval  = 0.1

    lazy var spiner: SpinerLayer! = {
        let s = SpinerLayer(frame: self.frame)
        self.layer.addSublayer(s)
        return s
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    override public var highlighted: Bool {
        didSet {
            if (highlighted) {
                self.backgroundColor = darkPink
            }
            else {
                self.backgroundColor = pink
            }
        }
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    func setup() {
        self.backgroundColor = pink
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }

    public func startLoadingAnimation() {
        self.titleLabel?.hidden = true
        self.shrink()
        NSTimer.schedule(delay: shrinkDuration - 0.25) { timer in
            self.spiner.animation()
        }
    }
    
    public func startFinishAnimation(completion:(()->())?) {
        self.didEndFinishAnimation = completion
        self.expand()
        self.spiner.stopAnimation()
    }
    
    public override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        let a = anim as! CABasicAnimation
        if a.keyPath == "transform.scale" {
            didEndFinishAnimation?()
            NSTimer.schedule(delay: 1) { timer in
                self.returnToOriginalState()
            }
        }
    }
    
    func returnToOriginalState() {
        self.layer.removeAllAnimations()
        self.titleLabel?.hidden = false
    }
    
    func shrink() {
        let shrinkAnim = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnim.fromValue = frame.width
        shrinkAnim.toValue = frame.height
        shrinkAnim.duration = shrinkDuration
        shrinkAnim.timingFunction = shrinkCurve
        shrinkAnim.fillMode = kCAFillModeForwards
        shrinkAnim.removedOnCompletion = false
        layer.addAnimation(shrinkAnim, forKey: shrinkAnim.keyPath)
    }
    
    func expand() {
        let expandAnim = CABasicAnimation(keyPath: "transform.scale")
        expandAnim.fromValue = 1.0
        expandAnim.toValue = 26.0
        expandAnim.timingFunction = expandCurve
        expandAnim.duration = 0.3
        expandAnim.delegate = self
        expandAnim.fillMode = kCAFillModeForwards
        expandAnim.removedOnCompletion = false
        layer.addAnimation(expandAnim, forKey: expandAnim.keyPath)
    }
    
}
