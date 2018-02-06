
# TKSubmitTransition

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
             )](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
             )](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
            )](http://mit-license.org)
[![CocoaPods](https://img.shields.io/cocoapods/v/TKSubmitTransition.svg)]()


Inpired by https://dribbble.com/shots/1945593-Login-Home-Screen

I created Animated UIButton of Loading Animation and Transition Animation.

As you can see in the GIF Animation Demo below, you can find the “Sign in” button rolling and after that, next UIViewController will fade-in. 

I made them as classes and you can use it with ease.

[Objective-C version is here.](https://github.com/wwdc14/HySubmitTransitionObjective-C)

# Demo
![Demo GIF Animation](https://github.com/entotsu/TKSubmitTransition/blob/master/demo.gif "Demo GIF Animation")

# Installation

## Cocoapods ##

**Swift 4**

``` ruby
pod 'TKSubmitTransition', :git => 'https://github.com/entotsu/TKSubmitTransition.git', :branch => 'swift4'
```

**Swift 3** 

``` ruby
pod 'TKSubmitTransition', :git => 'https://github.com/entotsu/TKSubmitTransition.git', :tag => '2.0'
```


**Swift 2 & Below** 

``` ruby
pod 'TKSubmitTransition', '~> 0.2' 
```


## Manually ##
Drag all the files from `SubmitTransition/Classes` into your project.

# Usage

### Storyboard

Just drag a `UIButton` on to your storyboard and change the custom class to `TKSubmitTransition` in the identity inspector.

![Button](http://i.imgur.com/mqSt8y8.png)

Change the settings of the button via the storyboard.

![Settings](http://i.imgur.com/maA1Aiw.png)

Then create an `IBOutlet` to your view controller.

![IBOutlet](http://i.imgur.com/1VK9umA.jpg)

You can now move on to `Animation Method` for further instructions.

### Programatically

You can use `TKTransitionSubmitButton` just like any other `UIButton`. It works practically the same.

Add this at the top of your file:

``` swift
import SubmitTransition
```

Then create a variable above your view did load for the button

``` swift
var bin: TKTransitionSubmitButton!
```

then finally in the view did load add the button

``` swift
btn = TKTransitionSubmitButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 64, height: 44))
btn.center = self.view.center
btn.frame.bottom = self.view.frame.height - 60
btn.setTitle("Sign in", for: UIControlState())
btn.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
self.view.addSubview(btn)
```

## Animation Method

Use this to animate your button. Follow the steps in `Delegation` to setup the transition.

``` swift
func didStartYourLoading() {
  btn.startLoadingAnimation()
}

func didFinishYourLoading() {
  btn.startFinishAnimation {
    //Your Transition
    let secondVC = SecondViewController()
    secondVC.transitioningDelegate = self
    self.presentViewController(secondVC, animated: true, completion: nil)
  }
}

```

## Networking

If you are running requests to a server and are waiting a responce, you can use something like this to stop and start the animation:

``` swift
// start loading the button animations
button.startLoadingAnimation()

// run query in background thread
async.background {
  let query = PFQuery(className: "Blah")
  query.whereKey("user", equalTo: user)
	let results = try! query.findObjects()
  
	if results.count == 0 {
		// insert alertView telling user that their details don't work
	}
	else {
		// return to main thread to complete login
		async.main {
                        // tell the button to finish its animations
			button.startFinishingAnimation(1) {
			        let sb = UIStoryboard(name: "Main", bundle: nil)
	            	        let vc = sb.instantiateViewController(withIdentifier: "MainVC")
			        vc.transitioningDelegate = self
			        self.present(vc, animated: true, completion: nil)
                        }
		}
	}
```
Thanks to [@sarfrazb](https://github.com/sarfrazb) for pointing this out.

## TKFadeInAnimator
This Library also supply fade-in Animator Class of `UIViewControllerAnimatedTransitioning`.

Please use This for transition animation.

### Delegation

#### Make sure your class implements the UIViewControllerTransitioningDelegate protocol like so
> class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

#### Setup the transitioning delegate
`secondVC.transitioningDelegate = self`

#### Implement the delegate

**Swift 3/4**

``` swift
func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
  return TKFadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
}

func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
  return nil
}
```

**Swift 2 & Below**

``` swift
// MARK: UIViewControllerTransitioningDelegate
func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
  let fadeInAnimator = TKFadeInAnimator()
  return fadeInAnimator
}

func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
  return nil
}

```

If you need any help with the setup feel free to look at the sample or create an issue.

# Contribution

- If you've found a bug, please open an issue.
- If you've a feature request, please open a pull request
- Please check any closed issues before you open a new one!

