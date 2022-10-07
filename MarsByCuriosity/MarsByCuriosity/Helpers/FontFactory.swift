//
//  FontFactory.swift
//  MarsByCuriosity
//
//

import UIKit

final class FontFactory {
    static func font(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
            case .bold:
                return bold(ofSize: size)
            case .light:
                return light(ofSize: size)
            default:
                return system(ofSize: size)
        }
    }
    
    static func bold(ofSize size: CGFloat ) -> UIFont {
        guard let font = UIFont(name: "Dosis-SemiBold", size: size) else {
            print("Font dosis.semibold not find!")
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        
        return font
    }
    
    static func system(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Dosis-Book", size: size) else {
            print("Font dosis.light not find!")
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        
        return font
    }
    
    static func light(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Dosis-Light", size: size) else {
            print("Font dosis.extralight not find!")
            return UIFont.systemFont(ofSize: size, weight: .light)
        }
        
        return font
    }
    
    static func regular(ofSize size: CGFloat) -> UIFont {
        return self.system(ofSize: size)
    }
}
