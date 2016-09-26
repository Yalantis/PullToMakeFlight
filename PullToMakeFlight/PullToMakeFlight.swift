//
//  Created by Anastasiya Gorban on 5/27/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//
//  Licensed under the MIT license: http://opensource.org/licenses/MIT
//  Latest version can be found at https://github.com/Yalantis/PullToMakeFlight
//

import Foundation
import CoreGraphics
import PullToRefresh

// MARK: - PullToMakeFlight

open class PullToMakeFlight: PullToRefresh {
    
    public convenience init(atPosition position: Position) {
        let height: CGFloat = 40
        let refreshView = Bundle(for: type(of: self)).loadNibNamed("FlightView", owner: nil, options: nil)?.first as! FlightView
        refreshView.clipsToBounds = true
        let animator =  FlightAnimator(refreshView: refreshView)
        self.init(refreshView: refreshView, animator: animator, height: height, position: position)
        self.hideDelay = 0.2
    }
}

// MARK: - FlightView

class FlightView: UIView {
    @IBOutlet
    fileprivate var cloudsLeft: UIView!
    @IBOutlet
    fileprivate var cloudsRight: UIView!
    @IBOutlet
    fileprivate var cloudsCenter: UIView!
    @IBOutlet
    fileprivate var airplane: UIView!
    @IBOutlet
    fileprivate var leftArrow: UIView!
    @IBOutlet
    fileprivate var leftArrowStick: UIImageView!
    @IBOutlet
    fileprivate var rightArrow: UIView!
    @IBOutlet
    fileprivate var rightArrowStick: UIView!
}

// MARK: - FlightAnimator

public class FlightAnimator : RefreshViewAnimator {
    
    fileprivate let refreshView: FlightView
    
    init(refreshView: FlightView) {
        self.refreshView = refreshView
    }
    
    // MARK: - RefreshViewAnimator
    
    public func animate(_ state: State) {
        switch state {
        case .initial:
            initalLayout()
        case .releasing(let progress):
            releasingAnimation(progress)
        case .loading:
            startLoading()
        case .finished:
            finish()
        }
    }
    
    // MARK: - Private
    
    fileprivate func initalLayout() {
        
        // clouds center
        
        refreshView.cloudsCenter.removeAllAnimations()
        refreshView.cloudsCenter.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        refreshView.cloudsCenter.layer.timeOffset = 0.0
        
        refreshView.cloudsCenter.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.PositionY,
            values: [110 as AnyObject, 95 as AnyObject],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))

        refreshView.cloudsCenter.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleX,
            values: [1 as AnyObject, 1.2 as AnyObject],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))

        refreshView.cloudsCenter.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleY,
            values: [1 as AnyObject, 1.2 as AnyObject],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        
        // clouds left
        
        refreshView.cloudsLeft.removeAllAnimations()
        refreshView.cloudsLeft.transform = CGAffineTransform(scaleX: 1, y: 1)
        refreshView.cloudsLeft.layer.timeOffset = 0.0
        
        refreshView.cloudsLeft.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.PositionY,
            values: [140 as AnyObject, 100 as AnyObject],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        
        refreshView.cloudsLeft.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleX,
            values: [1 as AnyObject, 1.3 as AnyObject],
            keyTimes: [0.5, 1],
            duration: 0.3,
            beginTime:0))
        
        refreshView.cloudsLeft.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleY,
            values: [1 as AnyObject, 1.3 as AnyObject],
            keyTimes: [0.5, 1],
            duration: 0.3,
            beginTime:0))

        // clouds right
        
        refreshView.cloudsRight.removeAllAnimations()
        refreshView.cloudsRight.transform = CGAffineTransform(scaleX: 1, y: 1)
        refreshView.cloudsRight.layer.timeOffset = 0.0
        
        refreshView.cloudsRight.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.PositionY,
            values: [140 as AnyObject, 100 as AnyObject],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        
        refreshView.cloudsRight.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleX,
            values: [1 as AnyObject, 1.3 as AnyObject],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        
        refreshView.cloudsRight.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleY,
            values: [1 as AnyObject, 1.3 as AnyObject],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        
        // airplane

        refreshView.airplane.layer.removeAllAnimations()
        refreshView.airplane.frame = CGRect(x: 77, y: 140, width: refreshView.airplane.frame.width, height: refreshView.airplane.frame.height)
        refreshView.airplane.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.Position,
            values: [NSValue(cgPoint: CGPoint(x: 77, y: 140)), NSValue(cgPoint: CGPoint(x: refreshView.frame.width / 2, y: 50))],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        refreshView.airplane.layer.timeOffset = 0.0
        
        // arrows
        
        refreshView.leftArrowStick.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        refreshView.rightArrowStick.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    fileprivate func releasingAnimation(_ progress: CGFloat) {
        if progress <= 1 {
            refreshView.cloudsCenter.layer.timeOffset = Double(progress) * 0.3
            refreshView.cloudsLeft.layer.timeOffset = Double(progress) * 0.3
            refreshView.cloudsRight.layer.timeOffset = Double(progress) * 0.3
            refreshView.airplane.layer.timeOffset = Double(progress) * 0.3
        }
        
        refreshView.leftArrow.frame = CGRect(
            x: refreshView.leftArrow.frame.origin.x,
            y: refreshView.cloudsRight.layer.presentation()!.frame.origin.y - refreshView.leftArrow.frame.height,
            width: refreshView.leftArrow.frame.width,
            height: refreshView.leftArrow.frame.height)
        
        refreshView.leftArrowStick.frame = CGRect(
            x: refreshView.leftArrowStick.frame.origin.x,
            y: refreshView.leftArrow.frame.origin.y - refreshView.leftArrowStick.frame.height + 5,
            width: refreshView.leftArrowStick.frame.width,
            height: 60 * progress)
        
        refreshView.rightArrow.frame = CGRect(
            x: refreshView.rightArrow.frame.origin.x,
            y: refreshView.leftArrow.frame.origin.y,
            width: refreshView.rightArrow.frame.width,
            height: refreshView.rightArrow.frame.height)
        
        refreshView.rightArrowStick.frame = CGRect(
            x: refreshView.rightArrowStick.frame.origin.x,
            y: refreshView.leftArrowStick.frame.origin.y,
            width: refreshView.rightArrowStick.frame.width,
            height: refreshView.leftArrowStick.frame.height)
    }
    
    fileprivate func startLoading() {
        refreshView.airplane.center = CGPoint(x: refreshView.frame.width / 2, y: 50)
        
        let airplaneAnimation = CAKeyframeAnimation.animationWith(
            AnimationType.PositionY,
            values: [50 as AnyObject, 45 as AnyObject, 50 as AnyObject, 55 as AnyObject, 50 as AnyObject],
            keyTimes: [0, 0.25, 0.5, 0.75, 1],
            duration: 2,
            beginTime: 0,
            timingFunctions: [TimingFunction.linear])
        
        airplaneAnimation.repeatCount = FLT_MAX;
        refreshView.airplane.layer.removeAllAnimations()
        refreshView.airplane.layer.add(airplaneAnimation, forKey: "")
        refreshView.airplane.layer.speed = 1
        
        refreshView.leftArrowStick.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        refreshView.rightArrowStick.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 7.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            var frame = self.refreshView.leftArrowStick.frame
            frame.size.height = 0
            frame.origin.y = self.refreshView.leftArrow.frame.origin.y
            self.refreshView.leftArrowStick.frame = frame
            
            frame = self.refreshView.rightArrowStick.frame
            frame.size.height = 0
            frame.origin.y = self.refreshView.leftArrow.frame.origin.y
            self.refreshView.rightArrowStick.frame = frame
            
        }, completion: nil)
    }
    
    fileprivate func finish() {
        refreshView.airplane.removeAllAnimations()
        refreshView.airplane.layer.timeOffset = 0.0
        refreshView.airplane.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.Position,
            values: [NSValue(cgPoint: CGPoint(x: refreshView.frame.width / 2, y: 50)), NSValue(cgPoint: CGPoint(x: refreshView.frame.width, y: -50))],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        refreshView.airplane.layer.speed = 1
    }
}


