//
//  UIDevice+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UIDevice {
    static var isIphone = (.phone == UIDevice.current.userInterfaceIdiom)
    
    static var isIphone4 = isIphone && (screenMaxSize == 480.0)
    static var isIphone5 = isIphone && (screenMaxSize == 568.0)
    static var isIphone8 = isIphone && (screenMaxSize == 667.0)
    static var isIphone8Plus = isIphone && (screenMaxSize == 736.0)
    static var isIphone12mini = isIphone && (screenMaxSize == 812)
    static var isSmallPhone = (isIphone4 || isIphone5)
    
    static var screenMaxSize: CGFloat { max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) }
    static var screenMinSize: CGFloat { min(UIScreen.main.bounds.height, UIScreen.main.bounds.width) }
}
