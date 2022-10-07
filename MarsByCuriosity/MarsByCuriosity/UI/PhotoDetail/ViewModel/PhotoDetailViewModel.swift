//
//  PhotoDetailViewModel.swift
//  MarsByCuriosity
//
//

import Foundation

final class PhotoDetailViewModel {
    private let photo: Photo
    
    var title = LS("PHOTO.ID.TITLE")
    
    lazy var subtitle = String(photo.id ?? 0)
    lazy var urlString = photo.imgSrc 
    lazy var image = photo.image
    
    init(photo: Photo) {
        self.photo = photo
    }
}
