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
}

// MARK: - DashboardTableViewCellViewModelDelegate
extension DashboardViewModel: DashboardTableViewCellViewModelDelegate {
    func reloadData() {
        delegate?.reloadData()
    }
}
