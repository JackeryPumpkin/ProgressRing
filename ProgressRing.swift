//
//  CounterView.swift
//  UIGraph
//
//  Created by Zachary Duncan on 7/16/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

import UIKit

@IBDesignable class ProgressRing: UIView {
    /// The number representing progress toward the maxProgress
    @IBInspectable var progress: CGFloat = 0 {
        didSet {
            if progress < minProgress {
                progress = minProgress
            } else if progress > maxProgress {
                progress = maxProgress
            }
            setNeedsDisplay()
        }
    }
    
    /// The number below which the progress cannot go
    @IBInspectable var minProgress: CGFloat = 0 {
        didSet {
            if progress < minProgress {
                progress = minProgress
            }
            setNeedsDisplay()
        }
    }
    
    /// The number above which the progress cannot go
    @IBInspectable var maxProgress: CGFloat = 100 { didSet { setNeedsDisplay() } }
    
    /// The amount by which the increase and decrease methods will affect the progress
    @IBInspectable var stepSize: CGFloat = 1 { didSet { setNeedsDisplay() } }
    
    /// The color to be used by the background ring
    @IBInspectable var circleColor: UIColor = #colorLiteral(red: 0.7843137255, green: 0.9882352941, blue: 0.9882352941, alpha: 1) { didSet { setNeedsDisplay() } }
    
    /// The color to be used by the progress ring
    @IBInspectable var progressColor: UIColor = #colorLiteral(red: 0.2176215278, green: 0.4485532407, blue: 1, alpha: 1) { didSet { setNeedsDisplay() } }
    
    /// The color to be used by the progress ring when it is full
    @IBInspectable var completeProgressColor: UIColor = #colorLiteral(red: 0.4857127568, green: 1, blue: 0.4857127568, alpha: 1) { didSet { setNeedsDisplay() } }
    
    /// The thickness of the background ring's path
    @IBInspectable var circleWidth: CGFloat = 30 { didSet { setNeedsDisplay() } }
    
    /// Returns the thickness of the progress ring's path
    var progressWidth: CGFloat { return circleWidth * 0.8 }
    
    /// The style used by the background and progress rings
    var lineCapStyle: CGLineCap = .round
    
    let startAngle: CGFloat = 0
    let endAngle: CGFloat = .pi * 2
    private var progressAngle: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        setProgressAngle()
        
        let middle = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = (min(rect.width, rect.height) / 2) - (circleWidth / 2)
        
        let circlePath = UIBezierPath(arcCenter: middle, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circlePath.lineWidth = circleWidth
        circlePath.lineCapStyle = lineCapStyle
        circleColor.setStroke()
        circlePath.stroke()
        circlePath.close()
        
        let progressPath = UIBezierPath(arcCenter: middle, radius: radius, startAngle: startAngle, endAngle: progressAngle, clockwise: true)
        progressPath.lineWidth = progressWidth
        progressPath.lineCapStyle = lineCapStyle
        
        if progress == maxProgress {
            completeProgressColor.setStroke()
        } else {
            progressColor.setStroke()
        }
        
        progressPath.stroke()
        progressPath.close()
        
        // This makes the origin of the circle at the top
        rotate(0)
    }
    
    /// - Parameter progress: This should be a CGFloat from 0.0 to 1.0
    func setProgressAngle() {
        let range = endAngle - startAngle
        let progressModifier = (progress - minProgress) / (maxProgress - minProgress)
        progressAngle = startAngle + range * progressModifier
    }
    
    /// - Parameter rotation: 1.0 is a 360 degree rotation, 0.0 is no movement
    func rotate(_ rotation: CGFloat) {
        transform = CGAffineTransform(rotationAngle: .pi * (1.5 + rotation * 2))
        setNeedsLayout()
    }
    
    /// Increases progress by one stepSize (default is 1)
    func increaseOneStep() {
        progress += stepSize
    }
    
    /// Decreases progress by one stepSize (default is 1)
    func decreaseOneStep() {
        progress -= stepSize
    }
}
