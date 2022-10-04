//
//  UIColor+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UIColor {
    convenience init(hexRGB:Int) {
        let r = (hexRGB & 0x00FF0000) >> 16
        let g = (hexRGB & 0x0000FF00) >> 8
        let b = (hexRGB & 0x000000FF)
        
        self.init(red: r, green: g, blue: b)
    }
    
    convenience init(red:Int, green: Int, blue: Int, alpha: Float) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alpha >= 0.0 && alpha <= 1.0, "Invalid alpha component")
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
