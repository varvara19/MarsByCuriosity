//
//  Photo.swift
//  MarsByCuriosity
//
//

import UIKit

final class Photo: Codable {
    var id, sol: Int?
    var camera: Camera?
    var imgSrc: String?
    var earthDate: String?
    var rover: Rover?
    
    var image: UIImage?

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}
