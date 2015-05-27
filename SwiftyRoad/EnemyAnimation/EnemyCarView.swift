//
// EnemyCarView.swift
// Generated by Core Animator version 1.0 on 24/02/15.
//
// DO NOT MODIFY THIS FILE. IT IS AUTO-GENERATED AND WILL BE OVERWRITTEN
//

import UIKit

@IBDesignable
class EnemyCarView : UIView {

	var viewsByName: [String : UIView]!

	// - MARK: Life Cycle

    init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 81, height: 125))
		self.setupHierarchy()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupHierarchy()
	}

	required init(coder aDecoder: NSCoder) {
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
		__scaling__.bounds = CGRect(x:0, y:0, width:81, height:125)
		__scaling__.center = CGPoint(x:40.9, y:62.8)
		self.addSubview(__scaling__)
		viewsByName["__scaling__"] = __scaling__

		let enemy = UIView()
		enemy.bounds = CGRect(x:0, y:0, width:81.0, height:124.0)
		enemy.layer.position = CGPoint(x:40.500, y:62.000)
		__scaling__.addSubview(enemy)
		viewsByName["enemy"] = enemy

		let cloud = UIImageView()
		cloud.bounds = CGRect(x:0, y:0, width:57.0, height:31.0)
		var imgWölkchen: UIImage!
		if let imagePath = bundle.pathForResource("wölkchen.png", ofType:nil) {
			imgWölkchen = UIImage(contentsOfFile:imagePath)
		}
		cloud.image = imgWölkchen
		cloud.contentMode = .Center;
		cloud.layer.position = CGPoint(x:53.454, y:16.524)
		cloud.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(1.51), 0.40, 0.40)
		enemy.addSubview(cloud)
		viewsByName["cloud"] = cloud

		let enemyCar = UIImageView()
		enemyCar.bounds = CGRect(x:0, y:0, width:81.0, height:124.0)
		var imgCar4: UIImage!
		if let imagePath = bundle.pathForResource("car4.png", ofType:nil) {
			imgCar4 = UIImage(contentsOfFile:imagePath)
		}
		enemyCar.image = imgCar4
		enemyCar.contentMode = .Center;
		enemyCar.layer.position = CGPoint(x:40.500, y:62.000)
		enemyCar.transform = CGAffineTransformMakeRotation(3.142)
		enemy.addSubview(enemyCar)
		viewsByName["enemyCar"] = enemyCar

		self.viewsByName = viewsByName
	}

	// - MARK: polute

	func addPoluteAnimation() {
		addPoluteAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false)
	}

	func addPoluteAnimation(#removedOnCompletion: Bool) {
		addPoluteAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion)
	}

	func addPoluteAnimationWithBeginTime(beginTime: CFTimeInterval, fillMode: String, removedOnCompletion: Bool) {
		let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

		let cloudOpacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
		cloudOpacityAnimation.duration = 0.750
		cloudOpacityAnimation.values = [0.000 as Float, 0.998 as Float, 0.000 as Float]
		cloudOpacityAnimation.keyTimes = [0.000 as Float, 0.333 as Float, 1.000 as Float]
		cloudOpacityAnimation.timingFunctions = [linearTiming, linearTiming]
		cloudOpacityAnimation.repeatCount = HUGE
		cloudOpacityAnimation.beginTime = beginTime
		cloudOpacityAnimation.fillMode = fillMode
		cloudOpacityAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["cloud"]?.layer.addAnimation(cloudOpacityAnimation, forKey:"polute_Opacity")

		let cloudScaleXAnimation = CAKeyframeAnimation(keyPath: "transform.scale.x")
		cloudScaleXAnimation.duration = 0.750
		cloudScaleXAnimation.values = [0.405 as Float, 0.405 as Float, 0.675 as Float]
		cloudScaleXAnimation.keyTimes = [0.000 as Float, 0.333 as Float, 1.000 as Float]
		cloudScaleXAnimation.timingFunctions = [linearTiming, linearTiming]
		cloudScaleXAnimation.repeatCount = HUGE
		cloudScaleXAnimation.beginTime = beginTime
		cloudScaleXAnimation.fillMode = fillMode
		cloudScaleXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["cloud"]?.layer.addAnimation(cloudScaleXAnimation, forKey:"polute_ScaleX")

		let cloudScaleYAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y")
		cloudScaleYAnimation.duration = 0.750
		cloudScaleYAnimation.values = [0.405 as Float, 0.405 as Float, 0.675 as Float]
		cloudScaleYAnimation.keyTimes = [0.000 as Float, 0.333 as Float, 1.000 as Float]
		cloudScaleYAnimation.timingFunctions = [linearTiming, linearTiming]
		cloudScaleYAnimation.repeatCount = HUGE
		cloudScaleYAnimation.beginTime = beginTime
		cloudScaleYAnimation.fillMode = fillMode
		cloudScaleYAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["cloud"]?.layer.addAnimation(cloudScaleYAnimation, forKey:"polute_ScaleY")

		let cloudTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		cloudTranslationXAnimation.duration = 0.750
		cloudTranslationXAnimation.values = [0.000 as Float, -2.690 as Float, -5.951 as Float, -11.460 as Float]
		cloudTranslationXAnimation.keyTimes = [0.000 as Float, 0.333 as Float, 0.500 as Float, 1.000 as Float]
		cloudTranslationXAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
		cloudTranslationXAnimation.repeatCount = HUGE
		cloudTranslationXAnimation.beginTime = beginTime
		cloudTranslationXAnimation.fillMode = fillMode
		cloudTranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["cloud"]?.layer.addAnimation(cloudTranslationXAnimation, forKey:"polute_TranslationX")

		let cloudTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		cloudTranslationYAnimation.duration = 0.750
		cloudTranslationYAnimation.values = [0.000 as Float, -32.641 as Float, -45.833 as Float, -62.777 as Float]
		cloudTranslationYAnimation.keyTimes = [0.000 as Float, 0.333 as Float, 0.500 as Float, 1.000 as Float]
		cloudTranslationYAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
		cloudTranslationYAnimation.repeatCount = HUGE
		cloudTranslationYAnimation.beginTime = beginTime
		cloudTranslationYAnimation.fillMode = fillMode
		cloudTranslationYAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["cloud"]?.layer.addAnimation(cloudTranslationYAnimation, forKey:"polute_TranslationY")
	}

	func removePoluteAnimation() {
		self.viewsByName["cloud"]?.layer.removeAnimationForKey("polute_Opacity")
		self.viewsByName["cloud"]?.layer.removeAnimationForKey("polute_ScaleX")
		self.viewsByName["cloud"]?.layer.removeAnimationForKey("polute_ScaleY")
		self.viewsByName["cloud"]?.layer.removeAnimationForKey("polute_TranslationX")
		self.viewsByName["cloud"]?.layer.removeAnimationForKey("polute_TranslationY")
	}

	func removeAllAnimations() {
		for subview in viewsByName.values {
			subview.layer.removeAllAnimations()
		}
	}
}