//
//  GetMarsPhotoResponse.swift
//  MarsByCuriosity
//
//

import Foundation

final class GetMarsPhotoResponse: Codable {
    let photos: [Photo]

    init(photos: [Photo]) {
        self.photos = photos
    }
}
