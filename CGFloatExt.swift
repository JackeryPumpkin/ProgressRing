//
//  CGFloatExt.swift
//  UIGraph
//
//  Created by Zachary Duncan on 7/23/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

import UIKit

extension CGFloat {
    func hundredthFormat() -> String {
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 2
        
        return numberFormatter.string(from: NSNumber(value: Float(self)))!
    }
    
    func wholeNumberFormat() -> String {
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: Float(self)))!
    }
}
