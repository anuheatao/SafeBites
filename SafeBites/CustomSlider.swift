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
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = 30
    newBounds.size.width += 10
        return newBounds
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
