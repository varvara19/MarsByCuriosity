//
//  UIFont+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UIFont {
    static func bold(ofSize size: CGFloat) -> UIFont     {  return FontFactory.bold(ofSize: size) }
    static func light(ofSize size: CGFloat) -> UIFont    {  return FontFactory.light(ofSize: size)  }
    static func system(ofSize size: CGFloat) -> UIFont   {  return FontFactory.system(ofSize: size) }
    static func regular(ofSize size: CGFloat) -> UIFont  {  return FontFactory.regular(ofSize: size) }
}
