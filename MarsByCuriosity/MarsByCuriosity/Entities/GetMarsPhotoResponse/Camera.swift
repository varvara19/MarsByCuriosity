//
//  Camera.swift
//  MarsByCuriosity
//
//

import Foundation

final class Camera: Codable {
    var id: Int?
    var name: String?
    var roverid: Int?
    var fullName: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverid = "rover_id"
        case fullName = "full_name"
    }
}
