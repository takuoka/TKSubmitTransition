//
//  FadeTransition.swift
//  SubmitTransition
//
//  Created by Takuya Okamoto on 2015/08/07.
//  Copyright (c) 2015年 Uniface. All rights reserved.
//

import UIKit


public class TKFadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var transitionDuration: NSTimeInterval = 0.5
    var startingAlpha: CGFloat = 0.0

    public convenience init(transitionDuration: NSTimeInterval, startingAlpha: CGFloat){
        self.init()
        self.transitionDuration = transitionDuration
        self.startingAlpha = startingAlpha
    }

    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionDuration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!

        toView.alpha = startingAlpha
        fromView.alpha = 0.8
        
        containerView!.addSubview(toView)
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
            
            toView.alpha = 1.0
            fromView.alpha = 0.0
            
            }, completion: {
                _ in
                fromView.alpha = 1.0
                transitionContext.completeTransition(true)
        })
    }
}
