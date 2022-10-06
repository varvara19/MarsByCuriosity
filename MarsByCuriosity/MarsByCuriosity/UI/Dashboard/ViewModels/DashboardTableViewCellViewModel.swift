//
//  DashboardTableViewCellViewModel.swift
//  MarsByCuriosity
//
//

import Foundation
import EventKit
import EventKitUI
import FloatingPanel

protocol DashboardTableViewCellViewModelDelegate: AnyObject {
    func reloadData()
}

final class DashboardTableViewCellViewModel {
    let title: String
    let type: DashboardViewModel.DashboardCellType
    
    var selectedValue: String?
    weak var delegate: DashboardTableViewCellViewModelDelegate?
    
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
                let floatingPanelController = CustomFloatingPanelController()
                
                let sourceArray = RoverCamera.allCases.map { $0.title }
                
                let contentViewController = ChooseValueTableViewController(viewModel: ChooseValueViewModel(title: title, sourceArray: sourceArray), chooseDelegate: self)
                floatingPanelController.set(contentViewController: contentViewController)
                
                UIApplication.present(presentVC: floatingPanelController)
        }
    }
}

// MARK: - ChooseValueTableViewControllerDelegate
extension DashboardTableViewCellViewModel: ChooseValueTableViewControllerDelegate {
    func valueDidSelected(value: String) {
        selectedValue = value
        delegate?.reloadData()
    }
}
