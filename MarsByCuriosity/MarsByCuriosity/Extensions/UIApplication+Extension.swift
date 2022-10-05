//
//  UIApplication+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UIApplication {
    static var rootViewController: RootViewController {
        let rootVC = UIApplication.shared.delegate?.window??.rootViewController as? RootViewController
        if rootVC == nil {
            assert( rootVC != nil, "Root view controller must be derived from CoreViewController")
        }
        
        return rootVC!
    }
}
