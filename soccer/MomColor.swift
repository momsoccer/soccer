//
//  MomColor.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 5..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import Foundation

struct MomClolor {
    
    static let mom_color1: String = "#303030"
    static let mom_color2: String = "#333333"
    static let mom_color3: String = "#464646"
    
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
