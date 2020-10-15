//
//  CustomSlider.swift
//  SafeBites
//
//  Created by athena on 10/13/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit
import Foundation

class CustomSlider: UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 30.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }

    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 30))
        super.trackRect(forBounds: customBounds)
        thumbTintColor = UIColor.systemOrange
        
        return customBounds
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
