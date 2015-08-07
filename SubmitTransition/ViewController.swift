//
//  ViewController.swift
//  SubmitTransition
//
//  Created by Takuya Okamoto on 2015/08/06.
//  Copyright (c) 2015年 Uniface. All rights reserved.


import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var btn: TKTransitionSubmitButton!
    t
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bg = UIImageView(image: UIImage(named: "Login"))
        bg.frame = self.view.frame
        self.view.addSubview(bg)
        
        btn = TKTransitionSubmitButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 64, height: 44))
        btn.center = self.view.center
        btn.frame.bottom = self.view.frame.height - 60
        btn.setTitle("Sign in", forState: .Normal)
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        btn.addTarget(self, action: "onTapButton", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
    }
    
    func onTapButton() {
        self.btn.startLoadingAnimation()
        NSTimer.schedule(delay: 1.0) { timer in
            self.btn.startFinishAnimation {
                let secondVC = SecondViewController()
                secondVC.transitioningDelegate = self
                self.presentViewController(secondVC, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let fadeInAnimator = TKFadeInAnimator()
        return fadeInAnimator
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

