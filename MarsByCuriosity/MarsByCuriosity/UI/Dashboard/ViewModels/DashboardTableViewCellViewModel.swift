//
//  DashboardTableViewCellViewModel.swift
//  MarsByCuriosity
//
//

import Foundation
import EventKit
import EventKitUI

final class DashboardTableViewCellViewModel {
    let title: String
    let type: DashboardViewModel.DashboardCellType
    
    var defaultValue: String {
        switch type {
            case .date:
                return DateFormatter.string(fromDate: Date(), with: "MMM d, yyyy") ?? ""
            case .selectionRoverCamera:
                return RoverCamera.FHAZ.title
        }
    }
    
    init(type: DashboardViewModel.DashboardCellType) {
        self.title = type.title
        self.type = type
    }
    
    func didSelectNewValue() {
        switch type {
            case .date:
                break
            case .selectionRoverCamera:
                break
        }
    }
}
