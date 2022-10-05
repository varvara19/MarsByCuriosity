//
//  Int+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension Int {
    var adapted: CGFloat { UIDevice.screenMinSize * CGFloat(self) / 375 }
}
