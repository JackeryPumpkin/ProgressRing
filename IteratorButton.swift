//
//  PushButton.swift
//  UIGraph
//
//  Created by Zachary Duncan on 7/16/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

import UIKit

@IBDesignable class IteratorButton: UIButton {
    @IBInspectable var fillColor: UIColor = #colorLiteral(red: 0.4077257127, green: 0.7301893835, blue: 0.9686274529, alpha: 1)
    @IBInspectable var strokeColor: UIColor = .white
    @IBInspectable var isAddButton: Bool = true
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func sharedInit() {
        addTarget(self, action: #selector(pressed), for: .touchDown)
        addTarget(self, action: #selector(pressed), for: .touchDragEnter)
        addTarget(self, action: #selector(unpressed), for: .touchUpInside)
        addTarget(self, action: #selector(unpressed), for: .touchDragExit)
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        //let path = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        fillColor.setFill()
        path.fill()
        
        //set up the width and height variables
        //for the horizontal stroke
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2
        
        //create the path
        let plusPath = UIBezierPath()
        plusPath.lineCapStyle = .round
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = Constants.plusLineWidth
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(
            x: halfWidth - halfPlusWidth,
            y: halfHeight))
        
        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x: halfWidth + halfPlusWidth,
            y: halfHeight))
        
        if isAddButton {
            //Vertical line
            plusPath.move(to: CGPoint(
                x: halfWidth,
                y: halfHeight + halfPlusWidth + Constants.halfPointShift))
            
            //add a point to the path at the end of the stroke
            plusPath.addLine(to: CGPoint(
                x: halfWidth,
                y: halfHeight - halfPlusWidth + Constants.halfPointShift))
        }
        
        //set the stroke color
        strokeColor.setStroke()
        
        //draw the stroke
        plusPath.stroke()
    }
    
    @objc func pressed() {
        fillColor -= 0.2
        setNeedsLayout()
    }
    
    @objc func unpressed() {
        fillColor += 0.2
        setNeedsLayout()
    }
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.5
        static let halfPointShift: CGFloat = 0.5
    }
}
