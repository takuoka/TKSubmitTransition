import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var btn: TKTransitionSubmitButton!

    @IBOutlet weak var btnFromNib: TKTransitionSubmitButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
        let bg = UIImageView(image: UIImage(named: "Login"))
        bg.frame = self.view.frame
        self.view.addSubview(bg)

        btn = TKTransitionSubmitButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 64, height: 44))
        btn.center = self.view.center
        btn.frame.bottom = self.view.frame.height - 60
        btn.setTitle("Sign in", for: UIControl.State())
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        btn.addTarget(self, action: #selector(ViewController.onTapButton(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)

        self.view.bringSubviewToFront(self.btnFromNib)
    }

    @IBAction func onTapButton(_ button: TKTransitionSubmitButton) {
        button.animate(1, completion: { () -> () in
            let secondVC = SecondViewController()
            secondVC.transitioningDelegate = self
            self.present(secondVC, animated: true, completion: nil)
        })
    }

    // MARK: UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TKFadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

