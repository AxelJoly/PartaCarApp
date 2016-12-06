//
// AnimationPartaCarView.swift
// Generated by Core Animator version 1.3.1 on 24/02/2016.
//
// DO NOT MODIFY THIS FILE. IT IS AUTO-GENERATED AND WILL BE OVERWRITTEN
//

import UIKit

@IBDesignable
class AnimationPartaCarView : UIView {


	var animationCompletions = Dictionary<CAAnimation, (Bool) -> Void>()
	var viewsByName: [String : UIView]!

	// - MARK: Life Cycle

	convenience init() {
		self.init(frame: CGRect(x: 0, y: 0, width: 1080, height: 1920))
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupHierarchy()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupHierarchy()
	}

	// - MARK: Scaling

	override func layoutSubviews() {
		super.layoutSubviews()

		if let scalingView = self.viewsByName["__scaling__"] {
			var xScale = self.bounds.size.width / scalingView.bounds.size.width
			var yScale = self.bounds.size.height / scalingView.bounds.size.height
			switch contentMode {
			case .ScaleToFill:
				break
			case .ScaleAspectFill:
				let scale = max(xScale, yScale)
				xScale = scale
				yScale = scale
			default:
				let scale = min(xScale, yScale)
				xScale = scale
				yScale = scale
			}
			scalingView.transform = CGAffineTransformMakeScale(xScale, yScale)
			scalingView.center = CGPoint(x:CGRectGetMidX(self.bounds), y:CGRectGetMidY(self.bounds))
		}
	}

	// - MARK: Setup

	func setupHierarchy() {
		var viewsByName: [String : UIView] = [:]
		let bundle = NSBundle(forClass:self.dynamicType)
		let __scaling__ = UIView()
		__scaling__.bounds = CGRect(x:0, y:0, width:1080, height:1920)
		__scaling__.center = CGPoint(x:540.0, y:960.0)
		self.addSubview(__scaling__)
		viewsByName["__scaling__"] = __scaling__

		let logolaunch = UIImageView()
		logolaunch.bounds = CGRect(x:0, y:0, width:347.0, height:347.0)
		logolaunch.layer.anchorPoint = CGPoint(x:0.506, y:0.508)
		var imgLogolaunch: UIImage!
		if let imagePath = bundle.pathForResource("logolaunch.png", ofType:nil) {
			imgLogolaunch = UIImage(contentsOfFile:imagePath)
		}else {
			print("** Warning: Could not create image from 'logolaunch.png'. Please make sure that it is added to the project directly (not in a folder reference).")
		}
		logolaunch.image = imgLogolaunch
		logolaunch.contentMode = .Center
		logolaunch.layer.position = CGPoint(x:542.023, y:518.711)
		__scaling__.addSubview(logolaunch)
		viewsByName["logolaunch"] = logolaunch

		let buttonInscri = UIImageView()
		buttonInscri.bounds = CGRect(x:0, y:0, width:450.0, height:200.0)
		var imgButtonInscri: UIImage!
		if let imagePath = bundle.pathForResource("buttonInscri.png", ofType:nil) {
			imgButtonInscri = UIImage(contentsOfFile:imagePath)
		}else {
			print("** Warning: Could not create image from 'buttonInscri.png'. Please make sure that it is added to the project directly (not in a folder reference).")
		}
		buttonInscri.image = imgButtonInscri
		buttonInscri.contentMode = .Center
		buttonInscri.layer.position = CGPoint(x:540.000, y:1359.738)
		buttonInscri.transform = CGAffineTransformMakeScale(0.67, 0.67)
		__scaling__.addSubview(buttonInscri)
		viewsByName["buttonInscri"] = buttonInscri

		let buttonCo2 = UIImageView()
		buttonCo2.bounds = CGRect(x:0, y:0, width:625.0, height:277.0)
		var imgButtonCo2: UIImage!
		if let imagePath = bundle.pathForResource("buttonCo2.png", ofType:nil) {
			imgButtonCo2 = UIImage(contentsOfFile:imagePath)
		}else {
			print("** Warning: Could not create image from 'buttonCo2.png'. Please make sure that it is added to the project directly (not in a folder reference).")
		}
		buttonCo2.image = imgButtonCo2
		buttonCo2.contentMode = .Center
		buttonCo2.layer.position = CGPoint(x:540.000, y:1175.462)
		buttonCo2.transform = CGAffineTransformMakeScale(0.49, 0.47)
		__scaling__.addSubview(buttonCo2)
		viewsByName["buttonCo2"] = buttonCo2

		self.viewsByName = viewsByName
	}

	// - MARK: Untitled Animation

	func addUntitledAnimation() {
		addUntitledAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: nil)
	}

	func addUntitledAnimation(completion: ((Bool) -> Void)?) {
		addUntitledAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: completion)
	}

	func addUntitledAnimation(removedOnCompletion removedOnCompletion: Bool) {
		addUntitledAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: nil)
	}

	func addUntitledAnimation(removedOnCompletion removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		addUntitledAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: completion)
	}

	func addUntitledAnimationWithBeginTime(beginTime: CFTimeInterval, fillMode: String, removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		if let complete = completion {
			let representativeAnimation = CABasicAnimation(keyPath: "not.a.real.key")
			representativeAnimation.duration = 0.500
			representativeAnimation.delegate = self
			self.layer.addAnimation(representativeAnimation, forKey: "UntitledAnimation")
			self.animationCompletions[layer.animationForKey("UntitledAnimation")!] = complete
		}

		let logolaunchOpacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
		logolaunchOpacityAnimation.duration = 0.500
		logolaunchOpacityAnimation.values = [0.000 as Float, 1.000 as Float]
		logolaunchOpacityAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		logolaunchOpacityAnimation.timingFunctions = [linearTiming]
		logolaunchOpacityAnimation.beginTime = beginTime
		logolaunchOpacityAnimation.fillMode = fillMode
		logolaunchOpacityAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["logolaunch"]?.layer.addAnimation(logolaunchOpacityAnimation, forKey:"Untitled Animation_Opacity")

		let logolaunchTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		logolaunchTranslationXAnimation.duration = 0.500
		logolaunchTranslationXAnimation.values = [-300.000 as Float, -4.609 as Float]
		logolaunchTranslationXAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		logolaunchTranslationXAnimation.timingFunctions = [linearTiming]
		logolaunchTranslationXAnimation.beginTime = beginTime
		logolaunchTranslationXAnimation.fillMode = fillMode
		logolaunchTranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["logolaunch"]?.layer.addAnimation(logolaunchTranslationXAnimation, forKey:"Untitled Animation_TranslationX")

		let buttonCo2OpacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
		buttonCo2OpacityAnimation.duration = 0.500
		buttonCo2OpacityAnimation.values = [0.000 as Float, 1.000 as Float]
		buttonCo2OpacityAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		buttonCo2OpacityAnimation.timingFunctions = [linearTiming]
		buttonCo2OpacityAnimation.beginTime = beginTime
		buttonCo2OpacityAnimation.fillMode = fillMode
		buttonCo2OpacityAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["buttonCo2"]?.layer.addAnimation(buttonCo2OpacityAnimation, forKey:"Untitled Animation_Opacity")

		let buttonCo2TranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		buttonCo2TranslationXAnimation.duration = 0.500
		buttonCo2TranslationXAnimation.values = [-300.000 as Float, 0.000 as Float]
		buttonCo2TranslationXAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		buttonCo2TranslationXAnimation.timingFunctions = [linearTiming]
		buttonCo2TranslationXAnimation.beginTime = beginTime
		buttonCo2TranslationXAnimation.fillMode = fillMode
		buttonCo2TranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["buttonCo2"]?.layer.addAnimation(buttonCo2TranslationXAnimation, forKey:"Untitled Animation_TranslationX")

		let buttonInscriOpacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
		buttonInscriOpacityAnimation.duration = 0.500
		buttonInscriOpacityAnimation.values = [0.000 as Float, 1.000 as Float]
		buttonInscriOpacityAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		buttonInscriOpacityAnimation.timingFunctions = [linearTiming]
		buttonInscriOpacityAnimation.beginTime = beginTime
		buttonInscriOpacityAnimation.fillMode = fillMode
		buttonInscriOpacityAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["buttonInscri"]?.layer.addAnimation(buttonInscriOpacityAnimation, forKey:"Untitled Animation_Opacity")

		let buttonInscriTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		buttonInscriTranslationXAnimation.duration = 0.500
		buttonInscriTranslationXAnimation.values = [-300.000 as Float, 0.000 as Float]
		buttonInscriTranslationXAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		buttonInscriTranslationXAnimation.timingFunctions = [linearTiming]
		buttonInscriTranslationXAnimation.beginTime = beginTime
		buttonInscriTranslationXAnimation.fillMode = fillMode
		buttonInscriTranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["buttonInscri"]?.layer.addAnimation(buttonInscriTranslationXAnimation, forKey:"Untitled Animation_TranslationX")

		let buttonInscriTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		buttonInscriTranslationYAnimation.duration = 0.500
		buttonInscriTranslationYAnimation.values = [0.000 as Float, 0.000 as Float]
		buttonInscriTranslationYAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		buttonInscriTranslationYAnimation.timingFunctions = [linearTiming]
		buttonInscriTranslationYAnimation.beginTime = beginTime
		buttonInscriTranslationYAnimation.fillMode = fillMode
		buttonInscriTranslationYAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["buttonInscri"]?.layer.addAnimation(buttonInscriTranslationYAnimation, forKey:"Untitled Animation_TranslationY")
	}

	func removeUntitledAnimation() {
		self.layer.removeAnimationForKey("UntitledAnimation")
		self.viewsByName["logolaunch"]?.layer.removeAnimationForKey("Untitled Animation_Opacity")
		self.viewsByName["logolaunch"]?.layer.removeAnimationForKey("Untitled Animation_TranslationX")
		self.viewsByName["buttonCo2"]?.layer.removeAnimationForKey("Untitled Animation_Opacity")
		self.viewsByName["buttonCo2"]?.layer.removeAnimationForKey("Untitled Animation_TranslationX")
		self.viewsByName["buttonInscri"]?.layer.removeAnimationForKey("Untitled Animation_Opacity")
		self.viewsByName["buttonInscri"]?.layer.removeAnimationForKey("Untitled Animation_TranslationX")
		self.viewsByName["buttonInscri"]?.layer.removeAnimationForKey("Untitled Animation_TranslationY")
	}

	override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
		if let completion = self.animationCompletions[anim] {
			self.animationCompletions.removeValueForKey(anim)
			completion(flag)
		}
	}

	func removeAllAnimations() {
		for subview in viewsByName.values {
			subview.layer.removeAllAnimations()
		}
		self.layer.removeAnimationForKey("UntitledAnimation")
	}
}