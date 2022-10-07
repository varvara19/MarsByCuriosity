//
//  MarsPhotoListViewModel.swift
//  MarsByCuriosity
//
//

import Foundation
import UIKit

protocol MarsPhotoListViewModelDelegate: AnyObject {
    func reloadData()
}

final class MarsPhotoListViewModel {
    
    var photos: [Photo]
    let date: Date
    let roverCamera: RoverCamera
    
    weak var delegate: MarsPhotoListViewModelDelegate?
    
    var isLoadingNextPage = false
    lazy var title = roverCamera.title
    
    var displayableDate: String {
        return DateFormatter.string(fromDate: date, with: AppConstants.displayableDateFormat) ?? ""
    }
    
    var serverDate: String {
        return DateFormatter.string(fromDate: date, with: AppConstants.serverDateFormat) ?? "none"
    }
    
    var currentPageNumber = 1
    
    init(roverCamera: RoverCamera, photos: [Photo], date: Date) {
        self.roverCamera = roverCamera
        self.photos = photos
        self.date = date
    }
    
    func loadNextPage() {
        guard photos.count >= 25 * currentPageNumber else { return }
        
        isLoadingNextPage = true
        
        GetMarsPhotoRequest(by: "2014-6-3", camera: roverCamera, page: currentPageNumber + 1) { response in
            guard response.photos.count > 0 else { AlertManager.showAlert(title: LS("ATTENTION"), message: LS("EMPTY.PHOTO.ARRAY.MESSAGE")); return }
            
            self.currentPageNumber += 1
            self.photos += response.photos
            self.isLoadingNextPage = false
            
            self.delegate?.reloadData()
        }.runRequest()
    }
    
    func didClickMarsPhoto(at indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        
        let detailController = PhotoDetailViewController(viewModel: PhotoDetailViewModel(photo: photo))
        
        UIApplication.push(viewController: detailController)
    }
}
