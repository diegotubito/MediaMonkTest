//
//  myBasicAnimation.swift
//  MediaMonksTest
//
//  Created by iMac on 14/03/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import UIKit

extension UIView {
    
    public func pauseAnimation(delay: Double) {
        let time = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, time, 0, 0, 0, { timer in
            let layer = self.layer
            let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
            layer.speed = 0.0
            layer.timeOffset = pausedTime
        })
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
    }
    
    public func resumeAnimation() {
        let pausedTime  = layer.timeOffset
        
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    }
    
    func slide(fromX: CGFloat?, toX: CGFloat, duration: TimeInterval) {
        
        let yPosition = self.frame.origin.y
        
        let height = self.frame.height
        let width = self.layer.frame.size.width
        
        
        if fromX != nil {
            self.frame = CGRect(x: fromX!, y: yPosition, width: width, height: height)
        }
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.frame = CGRect(x: toX, y: yPosition, width: width, height: height)
            
        })
    }
    
    func slide(fromX: CGFloat?, toX: CGFloat, duration: TimeInterval, completion: @escaping () -> Void) {
        
        let yPosition = self.frame.origin.y
        
        let height = self.frame.height
        let width = self.layer.frame.size.width
        
        if fromX != nil {
            self.frame = CGRect(x: fromX!, y: yPosition, width: width, height: height)
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.frame = CGRect(x: toX, y: yPosition, width: width, height: height)
            
        }) { (finished) in
            completion()
        }
    }
}


