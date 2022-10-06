//
//  DashboardViewModel.swift
//  MarsByCuriosity
//
//

import Foundation

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
    
    var sourceArray = [DashboardTableViewCellViewModel]()
    
    init() {
        configSourceArray()
    }
    
    private func configSourceArray() {
        sourceArray.append(DashboardTableViewCellViewModel(type: .selectionRoverCamera))
        sourceArray.append(DashboardTableViewCellViewModel(type: .date))
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        sourceArray[indexPath.row].didSelectNewValue()
    }
}
