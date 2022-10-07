//
//  Localization.swift
//  MarsByCuriosity
//
//

import Foundation

public func LS(_ key: String) -> String {
    return Bundle.main.localizedString(forKey: key, value: key, table: nil)
}
