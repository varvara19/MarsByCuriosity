//
//  Rover.swift
//  MarsByCuriosity
//
//

import Foundation

final class Rover: Codable {
    var id: Int?
    var name, landingDate, launchDate, status: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}
