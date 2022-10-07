//
//  ErrorInfo.swift
//  MarsByCuriosity
//
//

import Foundation

final class ErrorInfo: Codable, Error {
    let code: String?
    let message: String?
    let success: Bool?
    
    init(message: String?, code: String?, success: Bool?) {
        self.message = message
        self.code = code
        self.success = success
    }
}
