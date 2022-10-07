//
//  DateFormatter+Extension.swift
//  MarsByCuriosity
//
//

import Foundation

extension DateFormatter {
    static func date(fromString string:String, with formatString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        
        return formatter.date(from: string)
    }
    
    static func string(fromDate date:Date, with formatString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        
        return formatter.string(from: date)
    }
}
