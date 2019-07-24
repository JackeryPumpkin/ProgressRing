//
//  UIColorExt.swift
//  UIGraph
//
//  Created by Zachary Duncan on 7/22/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

import UIKit

extension UIColor {
    static func +(color: UIColor, modification: Double) -> UIColor {
        if let components = color.cgColor.components {
            var red: CGFloat = 0
            var blue: CGFloat = 0
            var green: CGFloat = 0
            
            for i in 0 ..< components.count {
                if i == 0 {
                    red = components[i]
                } else if i == 1 {
                    green = components[i]
                } else if i == 2 {
                    blue = components[i]
                }
            }
            
            return UIColor(red: red + CGFloat(modification),
                           green: green + CGFloat(modification),
                           blue: blue + CGFloat(modification),
                           alpha: color.cgColor.alpha)
        } else {
            return color
        }
    }
    
    static func -(color: UIColor, modification: Double) -> UIColor {
        return color + -modification
    }
    
    static func +=(color: inout UIColor, modification: Double) {
        color = color + modification
    }
    
    static func -=(color: inout UIColor, modification: Double) {
        color = color - modification
    }
    
    @objc func dodge(amount: Double) -> UIColor {
        return self + amount
    }
    
    @objc func burn(amount: Double) -> UIColor {
        return self - amount
    }
    
    static func >(left: UIColor, right: UIColor) -> Bool {
        guard let lComponents = left.cgColor.components else { return false }
        guard let rComponents = right.cgColor.components else { return false }
        
        var lTotal: CGFloat = 0
        var rTotal: CGFloat = 0
        
        for i in 0 ..< lComponents.count {
            if i != lComponents.count - 1 {
                lTotal += lComponents[i]
            }
        }
        
        for i in 0 ..< rComponents.count {
            if i != rComponents.count - 1 {
                rTotal += rComponents[i]
            }
        }
        
        return lTotal > rTotal
    }
    
    static func ==(left: UIColor, right: UIColor) -> Bool {
        guard let lComponents = left.cgColor.components else { return false }
        guard let rComponents = right.cgColor.components else { return false }
        
        var lTotal: CGFloat = 0
        var rTotal: CGFloat = 0
        
        for i in 0 ..< lComponents.count {
            if i != lComponents.count - 1 {
                lTotal += lComponents[i]
            }
        }
        
        for i in 0 ..< rComponents.count {
            if i != rComponents.count - 1 {
                rTotal += rComponents[i]
            }
        }
        
        return lTotal == rTotal
    }
    
    static func <(left: UIColor, right: UIColor) -> Bool {
        return !(left > right)
    }
    
    @objc func isDarkerThanColor(_ color: UIColor) -> Bool {
        return self < color
    }
    
    @objc func isLighterThanColor(_ color: UIColor) -> Bool {
        return self > color
    }
    
    @objc func isSameColorAs(_ color: UIColor) -> Bool {
        return self == color
    }
}
