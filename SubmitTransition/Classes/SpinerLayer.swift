import UIKit


class SpinerLayer :CAShapeLayer {
    
    init(frame:CGRect) {
        super.init()

        let radius:CGFloat = (frame.height / 2) * 0.5
        self.frame = CGRectMake(0, 0, frame.height, frame.height)
        var center = CGPointMake(frame.height / 2, bounds.center.y)
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
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0
        rotate.toValue = M_PI * 2
        rotate.duration = 0.4
        rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        rotate.repeatCount = HUGE
        rotate.fillMode = kCAFillModeForwards
        rotate.removedOnCompletion = false
        self.addAnimation(rotate, forKey: rotate.keyPath)

    }
    
    func stopAnimation() {
        self.hidden = true
        self.removeAllAnimations()
    }
}