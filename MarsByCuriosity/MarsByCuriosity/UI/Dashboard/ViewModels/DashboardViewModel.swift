//
//  DashboardViewModel.swift
//  MarsByCuriosity
//
//

import Foundation

protocol DashboardViewModelDelegate: AnyObject {
    func reloadData()
}

final class DashboardViewModel {
    enum DashboardCellType {
        case date
        case selectionRoverCamera
        
        var title: String {
            switch self {
                case .date: return LS("DATE.TITLE")
                case .selectionRoverCamera: return LS("ROVER.CAMERA.TITLE")
            }
        }
        
        var iconName: String {
            switch self {
                case .date: return "calendar"
                case .selectionRoverCamera: return "dropdown"
            }
        }
    }
    
    weak var delegate: DashboardViewModelDelegate?
    var sourceArray = [DashboardTableViewCellViewModel]()
    
    init(delegate: DashboardViewModelDelegate?) {
        self.delegate = delegate
        
        configSourceArray()
    }
    
    private func configSourceArray() {
        sourceArray.append(DashboardTableViewCellViewModel(type: .selectionRoverCamera))
        sourceArray.append(DashboardTableViewCellViewModel(type: .date))
        
        sourceArray.forEach { $0.delegate = self }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        sourceArray[indexPath.row].didSelectNewValue()
    }
    
    func didClickActionButton() {
        guard
            let selectedDate = sourceArray.first(where: { $0.type == .date })?.selectedValue,
            let date = DateFormatter.date(fromString: selectedDate, with: AppConstants.displayableDateFormat),
            let serverStringDate = DateFormatter.string(fromDate: date, with: AppConstants.serverDateFormat),
            let roverCameraTitle = sourceArray.first(where: { $0.type == .selectionRoverCamera })?.selectedValue,
            let roverCamera = RoverCamera.allCases.first(where: { $0.title == roverCameraTitle })
        else { return }
        
        
        GetMarsPhotoRequest(by: serverStringDate, camera: roverCamera, page: 1) { response in
            guard response.photos.count > 0 else { AlertManager.showAlert(title: LS("ATTENTION"), message: LS("EMPTY.PHOTO.ARRAY.MESSAGE")); return }
            
            
        }.runRequest()
    }
}

// MARK: - DashboardTableViewCellViewModelDelegate
extension DashboardViewModel: DashboardTableViewCellViewModelDelegate {
    func reloadData() {
        delegate?.reloadData()
    }
}
