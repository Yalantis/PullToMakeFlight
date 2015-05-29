//
//  PullToMakeFlight.swift
//  PullToMakeFlightDemo
//
//  Created by Anastasiya Gorban on 5/27/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

import Foundation
import PullToRefresh
import CoreGraphics

public class PullToMakeFlight: PullToRefresh {
    public convenience init() {
        
        let refreshView =  NSBundle(forClass: self.dynamicType).loadNibNamed("FlightView", owner: nil, options: nil).first as! FlightView
        let animator =  FlightAnimator(refreshView: refreshView)
        self.init(refreshView: refreshView, animator: animator)
    }
}

class FlightView: UIView {
    
    @IBOutlet
    private var cloudsLeft: UIView!
    @IBOutlet
    private var cloudsRight: UIView!
    @IBOutlet
    private var cloudsCenter: UIView!
    @IBOutlet
    private var airplane: UIView!
}

class FlightAnimator : RefreshViewAnimator {
    
    private let refreshView: FlightView
    
    init(refreshView: FlightView) {
        self.refreshView = refreshView
    }
    
    
    func animateState(state: State) {
        switch state {
        case .Inital:
            initalLayout()
        case .Releasing(let progress):
            releasingAnimation(progress)
        case .Loading:
            startLoading()
        case .Finished:
            finish()
        }
    }
    
    private func initalLayout() {
        
        // clouds center
        
        refreshView.cloudsCenter.removeAllAnimations()
        refreshView.cloudsCenter.transform = CGAffineTransformMakeScale(1, 1)
        refreshView.cloudsCenter.layer.timeOffset = 0.0
        
        refreshView.cloudsCenter.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.PositionY,
            values: [110, 95],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))

        refreshView.cloudsCenter.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleX,
            values: [1, 1.2],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))

        refreshView.cloudsCenter.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleY,
            values: [1, 1.2],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        
        // clouds left
        
        refreshView.cloudsLeft.removeAllAnimations()
        refreshView.cloudsLeft.transform = CGAffineTransformMakeScale(1, 1)
        refreshView.cloudsLeft.layer.timeOffset = 0.0
        
        refreshView.cloudsLeft.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.PositionY,
            values: [140, 100],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        
        refreshView.cloudsLeft.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleX,
            values: [1, 1.3],
            keyTimes: [0.5, 1],
            duration: 0.3,
            beginTime:0))
        
        refreshView.cloudsLeft.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleY,
            values: [1, 1.3],
            keyTimes: [0.5, 1],
            duration: 0.3,
            beginTime:0))

        // clouds right
        
        refreshView.cloudsRight.removeAllAnimations()
        refreshView.cloudsRight.transform = CGAffineTransformMakeScale(1, 1)
        refreshView.cloudsRight.layer.timeOffset = 0.0
        
        refreshView.cloudsRight.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.PositionY,
            values: [140, 100],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        
        refreshView.cloudsRight.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleX,
            values: [1, 1.3],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        
        refreshView.cloudsRight.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.ScaleY,
            values: [1, 1.3],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        
        // airplane

        refreshView.airplane.layer.removeAllAnimations()
        refreshView.airplane.frame = CGRectMake(77, 140, refreshView.airplane.frame.width, refreshView.airplane.frame.height)
        refreshView.airplane.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.Position,
            values: [NSValue(CGPoint: CGPointMake(77, 140)), NSValue(CGPoint: CGPointMake(refreshView.frame.width / 2, 50))],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
        refreshView.airplane.layer.timeOffset = 0.0
    }
    
    private func releasingAnimation(progress: CGFloat) {
        refreshView.cloudsCenter.layer.timeOffset = Double(progress) * 0.3
        refreshView.cloudsLeft.layer.timeOffset = Double(progress) * 0.3
        refreshView.cloudsRight.layer.timeOffset = Double(progress) * 0.3
        refreshView.airplane.layer.timeOffset = Double(progress) * 0.3
    }
    
    private func startLoading() {
        refreshView.airplane.center = CGPointMake(refreshView.frame.width / 2, 50)
        
        let airplaneAnimation = CAKeyframeAnimation.animationWith(
            AnimationType.PositionY,
            values: [50, 45, 50, 55, 50],
            keyTimes: [0, 0.25, 0.5, 0.75, 1],
            duration: 2,
            beginTime: 0,
            timingFunctions: [TimingFunction.Linear])
        
        airplaneAnimation.repeatCount = FLT_MAX;
        refreshView.airplane.layer.removeAllAnimations()
        refreshView.airplane.layer.addAnimation(airplaneAnimation, forKey: "")
        refreshView.airplane.layer.speed = 1
    }
    
    private func finish() {
        refreshView.airplane.removeAllAnimations()
        refreshView.airplane.addAnimation(CAKeyframeAnimation.animationWith(
            AnimationType.Position,
            values: [NSValue(CGPoint: CGPointMake(refreshView.frame.width / 2, 50)), NSValue(CGPoint: CGPointMake(refreshView.frame.width, -50))],
            keyTimes: [0, 1],
            duration: 0.3,
            beginTime:0))
    }
}


