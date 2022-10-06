//
//  ChooseDateViewController.swift
//  MarsByCuriosity
//
//

import UIKit

final class ChooseDateViewController: CoreViewController {
    weak var chooseDelegate: ChooseValueDelegate?
    
    private let headerView = FloatingPanelHeaderView(title: LS("DATE.TITLE"), iconName: "calendar")
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(didChangePicker), for: .valueChanged)
        datePicker.tintColor = .appRed
        datePicker.maximumDate = Date()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        return datePicker
    }()
    
    init(chooseDelegate: ChooseValueDelegate?, selectedDate: Date) {
        self.chooseDelegate = chooseDelegate
        
        super.init(nibName: nil, bundle: nil)
        
        datePicker.date = selectedDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(datePicker)
    }
    
    override func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc private func didChangePicker() {
        dismiss(animated: true) {
            guard let stringDate = DateFormatter.string(fromDate: self.datePicker.date, with: AppConstants.displayableDateFormat) else { return }
            
            self.chooseDelegate?.valueDidSelected(value: stringDate)
        }
    }
}
