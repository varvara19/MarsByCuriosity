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
    private let floatingPanelController = CustomFloatingPanelController()
    
    let title: String
    let type: DashboardViewModel.DashboardCellType
    
    var selectedValue: String?
    weak var delegate: DashboardTableViewCellViewModelDelegate?
    
    var defaultValue: String {
        switch type {
            case .date:
                return DateFormatter.string(fromDate: Date(), with: AppConstants.displayableDateFormat) ?? ""
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
                guard let date = DateFormatter.date(fromString: selectedValue ?? defaultValue, with: AppConstants.displayableDateFormat) else { return }
                
                let contentViewController = ChooseDateViewController(chooseDelegate: self, selectedDate: date)
                floatingPanelController.set(contentViewController: contentViewController)
                
                UIApplication.present(presentVC: floatingPanelController)
            case .selectionRoverCamera:
                
                let sourceArray = RoverCamera.allCases.map { $0.title }
                
                let contentViewController = ChooseValueTableViewController(viewModel: ChooseValueViewModel(title: title, sourceArray: sourceArray), chooseDelegate: self)
                floatingPanelController.set(contentViewController: contentViewController)
                
                UIApplication.present(presentVC: floatingPanelController)
        }
    }
}

// MARK: - ChooseValueTableViewControllerDelegate
extension DashboardTableViewCellViewModel: ChooseValueDelegate {
    func valueDidSelected(value: String) {
        selectedValue = value
        delegate?.reloadData()
    }
}
