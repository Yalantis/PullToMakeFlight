//
//  Created by Serhii Butenko on 26/9/16.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//
//  Licensed under the MIT license: http://opensource.org/licenses/MIT
//  Latest version can be found at https://github.com/Yalantis/PullToMakeFlight
//

import Foundation
import PullToRefresh

public class FlightAnimator: RefreshViewAnimator {
    
    fileprivate let refreshView: FlightView
    
    init(refreshView: FlightView) {
        self.refreshView = refreshView
    }
    
    public func animate(_ state: State) {
        switch state {
        case .initial:
            layoutInitialState()
            
        case .releasing(let progress):
            layoutReleasingState(with: progress)
            
        case .loading:
            layoutLoadingState()
            
        case .finished:
            layoutFinishState()
        }
    }
}

fileprivate extension FlightAnimator {
    
    fileprivate func layoutInitialState() {
        initialLayoutForCenterClouds()
        initialLayoutForLeftClouds()
        initialLayoutForRightClouds()
        initialLayoutForAirplane()
        initialLayoutForArrows()
    }
    
    fileprivate func layoutReleasingState(with progress: CGFloat) {
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
            height: refreshView.leftArrow.frame.height
        )
        
        refreshView.leftArrowStick.frame = CGRect(
            x: refreshView.leftArrowStick.frame.origin.x,
            y: refreshView.leftArrow.frame.origin.y - refreshView.leftArrowStick.frame.height + 5,
            width: refreshView.leftArrowStick.frame.width,
            height: 60 * progress
        )
        
        refreshView.rightArrow.frame = CGRect(
            x: refreshView.rightArrow.frame.origin.x,
            y: refreshView.leftArrow.frame.origin.y,
            width: refreshView.rightArrow.frame.width,
            height: refreshView.rightArrow.frame.height
        )
        
        refreshView.rightArrowStick.frame = CGRect(
            x: refreshView.rightArrowStick.frame.origin.x,
            y: refreshView.leftArrowStick.frame.origin.y,
            width: refreshView.rightArrowStick.frame.width,
            height: refreshView.leftArrowStick.frame.height
        )
    }
    
    fileprivate func layoutLoadingState() {
        refreshView.airplane.center = CGPoint(x: refreshView.frame.width / 2, y: 50)
        let airplaneAnimation = CAKeyframeAnimation.animation(
            for: .positionY,
            values: [50, 45, 50, 55, 50],
            keyTimes: [0, 0.25, 0.5, 0.75, 1],
            duration: 2,
            beginTime: 0,
            timingFunctions: [.linear]
        )
        
        airplaneAnimation.repeatCount = FLT_MAX;
        refreshView.airplane.layer.removeAllAnimations()
        refreshView.airplane.layer.add(airplaneAnimation, forKey: "")
        refreshView.airplane.layer.speed = 1
        
        refreshView.leftArrowStick.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        refreshView.rightArrowStick.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 7.0,
            options: .curveEaseIn,
            animations: {
                var frame = self.refreshView.leftArrowStick.frame
                frame.size.height = 0
                frame.origin.y = self.refreshView.leftArrow.frame.origin.y
                self.refreshView.leftArrowStick.frame = frame
                
                frame = self.refreshView.rightArrowStick.frame
                frame.size.height = 0
                frame.origin.y = self.refreshView.leftArrow.frame.origin.y
                self.refreshView.rightArrowStick.frame = frame
            },
            completion: nil
        )
    }
    
    fileprivate func layoutFinishState() {
        refreshView.airplane.removeAllAnimations()
        refreshView.airplane.layer.timeOffset = 0.0
        refreshView.airplane.addAnimation(CAKeyframeAnimation.animation(
            for: .position,
            values: [NSValue(cgPoint: CGPoint(x: refreshView.frame.width / 2, y: 50)), NSValue(cgPoint: CGPoint(x: refreshView.frame.width, y: -50))],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0)
        )
        refreshView.airplane.layer.speed = 1
    }
}

// Layout
fileprivate extension FlightAnimator {
    
    func initialLayoutForCenterClouds() {
        refreshView.cloudsCenter.removeAllAnimations()
        refreshView.cloudsCenter.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        refreshView.cloudsCenter.layer.timeOffset = 0.0
        
        refreshView.cloudsCenter.addAnimation(CAKeyframeAnimation.animation(
            for: AnimationType.positionY,
            values: [110, 95],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0)
        )
        
        refreshView.cloudsCenter.addAnimation(CAKeyframeAnimation.animation(
            for: AnimationType.scaleX,
            values: [1, 1.2],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0)
        )
        
        refreshView.cloudsCenter.addAnimation(CAKeyframeAnimation.animation(
            for: AnimationType.scaleY,
            values: [1, 1.2],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0)
        )
    }
    
    func initialLayoutForLeftClouds() {
        refreshView.cloudsLeft.removeAllAnimations()
        refreshView.cloudsLeft.transform = CGAffineTransform(scaleX: 1, y: 1)
        refreshView.cloudsLeft.layer.timeOffset = 0.0
        
        refreshView.cloudsLeft.addAnimation(CAKeyframeAnimation.animation(
            for: .positionY,
            values: [140, 100],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0)
        )
        
        refreshView.cloudsLeft.addAnimation(CAKeyframeAnimation.animation(
            for: .scaleX,
            values: [1, 1.3],
            keyTimes: [0.5, 1],
            duration: 0.3,
            beginTime:0)
        )
        
        refreshView.cloudsLeft.addAnimation(CAKeyframeAnimation.animation(
            for: .scaleY,
            values: [1, 1.3],
            keyTimes: [0.5, 1],
            duration: 0.3,
            beginTime:0)
        )
    }
    
    func initialLayoutForRightClouds() {
        refreshView.cloudsRight.removeAllAnimations()
        refreshView.cloudsRight.transform = CGAffineTransform(scaleX: 1, y: 1)
        refreshView.cloudsRight.layer.timeOffset = 0.0
        
        refreshView.cloudsRight.addAnimation(CAKeyframeAnimation.animation(
            for: .positionY,
            values: [140, 100],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0)
        )
        
        refreshView.cloudsRight.addAnimation(CAKeyframeAnimation.animation(
            for: .scaleX,
            values: [1, 1.3],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0)
        )
        
        refreshView.cloudsRight.addAnimation(CAKeyframeAnimation.animation(
            for: .scaleY,
            values: [1, 1.3],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0)
        )
    }
    
    func initialLayoutForAirplane() {
        refreshView.airplane.layer.removeAllAnimations()
        refreshView.airplane.frame = CGRect(x: 77, y: 140, width: refreshView.airplane.frame.width, height: refreshView.airplane.frame.height)
        refreshView.airplane.addAnimation(CAKeyframeAnimation.animation(
            for: .position,
            values: [NSValue(cgPoint: CGPoint(x: 77, y: 140)), NSValue(cgPoint: CGPoint(x: refreshView.frame.width / 2, y: 50))],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0)
        )
        refreshView.airplane.layer.timeOffset = 0.0
    }
    
    func initialLayoutForArrows() {
        refreshView.leftArrowStick.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        refreshView.rightArrowStick.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
}
