//
//  Spiner.swift
//  SubmitTransition
//
//  Created by Takuya Okamoto on 2015/08/07.
//  Copyright (c) 2015年 Uniface. All rights reserved.
//

import UIKit


class SpinerLayer :CAShapeLayer {

    
//    let circlePath: CGPath = {
//        let p = CGPathCreateMutable()
////        CGPathAddArc(p, nil, 25.0, 25.0, 25.0, 0.0, 2.0 * M_PI, true)
//        CGPathCloseSubpath(p)
//        return p
//    }()

    init(frame:CGRect) {
        super.init()

        let radius:CGFloat = (frame.height / 2) * 0.5
        self.frame = CGRectMake(0, 0, frame.height, frame.height)
        var center = CGPointMake(frame.height / 2, frame.center.y)
        let startAngle = 0 - M_PI_2
        let endAngle = M_PI * 2 - M_PI_2
        let clockwise: Bool = true
        self.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).CGPath

        self.fillColor = nil
        self.strokeColor = UIColor.whiteColor().CGColor
        self.lineWidth = 1
        
        self.strokeEnd = 0.4
        self.hidden = true
     }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animation() {
        self.hidden = false
//        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
//        strokeEnd.fromValue = 0
//        strokeEnd.toValue = 1
//        strokeEnd.duration = 1.2
//        strokeEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//
//        let strokeStart = CABasicAnimation(keyPath: "strokeStart")
//        strokeStart.fromValue = 0
//        strokeStart.toValue = 1
//        strokeStart.duration = strokeEnd.duration
//        let delay = strokeEnd.duration / 3
//        strokeStart.beginTime = CACurrentMediaTime() + delay
//        strokeStart.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

//        let group = CAAnimationGroup()
//        group.animations = [strokeStart]//[strokeEnd, strokeStart]
//        group.duration = delay + strokeStart.duration - 0.1
//        group.repeatCount = HUGE
//        self.addAnimation(group, forKey: "spin")

        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0
        rotate.toValue = M_PI * 2
        rotate.duration = 0.4
        rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
//        strokeEnd.repeatCount = HUGE
//        strokeStart.repeatCount = HUGE
        rotate.repeatCount = HUGE
//        self.addAnimationStaticaly(strokeEnd)
//        self.addAnimationStaticaly(strokeStart)
        self.addAnimationStaticaly(rotate)
    }
    
    func stopAnimation() {
        self.hidden = true
        self.removeAllAnimations()
    }
}