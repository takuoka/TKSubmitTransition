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
    
    let pink = UIColor(red:0.992157, green: 0.215686, blue: 0.403922, alpha: 1)
    let springGoEase = CAMediaTimingFunction(controlPoints: 0.45,-0.36,0.44,0.92)
    let shrinkCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    //CAMediaTimingFunction(controlPoints: 0.93,-0.35,1,0.41)
    let expandCurve = CAMediaTimingFunction(controlPoints: 0.95,0.02,1,0.05)
    let spiner: SpinerLayer!

    public var didEndFinishAnimation : (()->())? = nil
    
    let shrinkDuration: CFTimeInterval  = 0.1
    
    public override init(frame: CGRect) {
        self.spiner = SpinerLayer(frame: frame)

        super.init(frame: frame)
        
        self.backgroundColor = pink
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true

        self.layer.addSublayer(self.spiner)        
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    
    
    func shrink() {
        let shrinkAnim = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnim.fromValue = frame.width
        shrinkAnim.toValue = frame.height
        shrinkAnim.duration = shrinkDuration
        shrinkAnim.timingFunction = shrinkCurve
        self.layer.addAnimationStaticaly(shrinkAnim)
    }
    
    func expand() {
        let expandAnim = CABasicAnimation(keyPath: "transform.scale")
        expandAnim.fromValue = 1.0
        expandAnim.toValue = 26.0
        expandAnim.timingFunction = expandCurve
        expandAnim.duration = 0.3
        expandAnim.delegate = self
        layer.addAnimationStaticaly(expandAnim)
    }
    
        
    
    public override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        let a = anim as! CABasicAnimation
        if a.keyPath == "transform.scale" {
            didEndFinishAnimation?()
        }
    }
}


extension CALayer {
    func addAnimationStaticaly(anim: CABasicAnimation) {
        anim.fillMode = kCAFillModeForwards
        anim.removedOnCompletion = false
        self.addAnimation(anim, forKey: anim.keyPath)
    }
}
