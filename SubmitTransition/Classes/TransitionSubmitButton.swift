import Foundation
import UIKit

@IBDesignable
public class TKTransitionSubmitButton : UIButton, UIViewControllerTransitioningDelegate, CAAnimationDelegate {
    
    lazy var spiner: SpinerLayer! = {
        let s = SpinerLayer(frame: self.frame)
        self.layer.addSublayer(s)
        return s
    }()
    
    @IBInspectable public var spinnerColor: UIColor = UIColor.white {
        didSet {
            spiner.spinnerColor = spinnerColor
        }
    }
    
    public var didEndFinishAnimation : (()->())? = nil

    let springGoEase = CAMediaTimingFunction(controlPoints: 0.45, -0.36, 0.44, 0.92)
    let shrinkCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    let expandCurve = CAMediaTimingFunction(controlPoints: 0.95, 0.02, 1, 0.05)
    let shrinkDuration: CFTimeInterval  = 0.1
    @IBInspectable public var normalCornerRadius:CGFloat? = 0.0{
        didSet {
            self.layer.cornerRadius = normalCornerRadius!
        }
    }

    var cachedTitle: String?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    public required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }

    func setup() {
        self.clipsToBounds = true
        spiner.spinnerColor = spinnerColor
    }

    public func startLoadingAnimation() {
        
        if(spiner.frame != self.frame) {
            spiner.removeFromSuperlayer()
            
            let s = SpinerLayer(frame: self.frame)
            s.spinnerColor = spinnerColor
            self.layer.addSublayer(s)
            
            spiner = s
        }
        
        self.cachedTitle = title(for: .normal)
        self.setTitle("", for: .normal)
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.layer.cornerRadius = self.frame.height / 2
            }) { (done) -> Void in
                self.shrink()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + self.shrinkDuration - 0.25) {
                    self.spiner.animation()
                }
        }
        
    }

    public func startFinishAnimation(delay: TimeInterval = 0, completion:(()->())? = {}) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.didEndFinishAnimation = completion
            self.expand()
            self.spiner.stopAnimation()
        }
    }

    public func animate(duration: TimeInterval, completion:(()->())?) {
        startLoadingAnimation()
        startFinishAnimation(delay: duration, completion: completion)
    }

    public func setOriginalState() {
        self.returnToOriginalState()
        self.spiner.stopAnimation()
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let a = anim as! CABasicAnimation
        if a.keyPath == "transform.scale" {
            didEndFinishAnimation?()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.returnToOriginalState()
            }
        }
    }
    
    public func returnToOriginalState() {
        
        self.layer.removeAllAnimations()
        self.setTitle(self.cachedTitle, for: .normal)
        self.spiner.stopAnimation()
    }
    
    func shrink() {
        let shrinkAnim = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnim.fromValue = frame.width
        shrinkAnim.toValue = frame.height
        shrinkAnim.duration = shrinkDuration
        shrinkAnim.timingFunction = shrinkCurve
        shrinkAnim.fillMode = kCAFillModeForwards
        shrinkAnim.isRemovedOnCompletion = false
        layer.add(shrinkAnim, forKey: shrinkAnim.keyPath)
    }
    
    func expand() {
        let expandAnim = CABasicAnimation(keyPath: "transform.scale")
        expandAnim.fromValue = 1.0
        expandAnim.toValue = 26.0
        expandAnim.timingFunction = expandCurve
        expandAnim.duration = 0.3
        expandAnim.delegate = self
        expandAnim.fillMode = kCAFillModeForwards
        expandAnim.isRemovedOnCompletion = false
        layer.add(expandAnim, forKey: expandAnim.keyPath)
    }
    
}
