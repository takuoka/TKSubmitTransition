import UIKit


class SpinerLayer: CAShapeLayer {
    
    var spinnerColor = UIColor.white {
        didSet {
            strokeColor = spinnerColor.cgColor
        }
    }
    
    init(frame:CGRect) {
        super.init()
        
        let radius:CGFloat = (frame.height / 2) * 0.5
        self.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height)
        
        let center = CGPoint(x: frame.height / 2, y: bounds.center.y)
        let startAngle = 0 - (Double.pi / 2)
        let endAngle = Double.pi * 2 - (Double.pi / 2)
        let clockwise: Bool = true
        self.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).cgPath
        
        self.fillColor = nil
        self.strokeColor = spinnerColor.cgColor
        self.lineWidth = 1
        
        self.strokeEnd = 0.4
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animation() {
        self.isHidden = false
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0
        rotate.toValue = Double.pi * 2
        rotate.duration = 0.4
        rotate.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        rotate.repeatCount = HUGE
        rotate.fillMode = CAMediaTimingFillMode.forwards
        rotate.isRemovedOnCompletion = false
        self.add(rotate, forKey: rotate.keyPath)
        
    }
    
    func stopAnimation() {
        self.isHidden = true
        self.removeAllAnimations()
    }
}
