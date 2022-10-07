//
//  UILabel+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UILabel {
    convenience init(text: String? = nil,
                     font: UIFont? = nil,
                     textColor: UIColor? = nil,
                     textAlignment: NSTextAlignment? = nil,
                     numberOfLines: Int? = nil,
                     lineBreakMode: NSLineBreakMode? = nil) {
        
        self.init(frame: CGRect.zero)
        
        if let text = text { self.text = text }
        
        if let font = font { self.font = font }
        
        if let textColor = textColor { self.textColor = textColor }
        
        if let textAlignment = textAlignment { self.textAlignment = textAlignment }
        
        if let numberOfLines = numberOfLines { self.numberOfLines = numberOfLines }
        
        if let lineBreakMode = lineBreakMode { self.lineBreakMode = lineBreakMode }
        
        self.backgroundColor = UIColor.clear
    }
}
