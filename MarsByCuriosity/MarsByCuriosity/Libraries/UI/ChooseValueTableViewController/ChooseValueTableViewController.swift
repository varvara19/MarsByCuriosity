//
//  ChooseValueTableViewController.swift
//  MarsByCuriosity
//
//

import UIKit

protocol ChooseValueDelegate: AnyObject {
    func valueDidSelected(value: String)
}

final class ChooseValueTableViewController: CoreViewController {
    private enum Dimensions {
        static let bottomInset: CGFloat = 8
    }
    
    weak var chooseDelegate: ChooseValueDelegate?
    
    private let viewModel: ChooseValueViewModel
    private lazy var headerView = FloatingPanelHeaderView(title: viewModel.title, iconName: "dropdown")
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = true
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(ChooseValueTableViewCell.self)
        tableView.setAndLayoutTableHeaderView(header: headerView)
        return tableView
    }()
    
    init(viewModel: ChooseValueViewModel, chooseDelegate:ChooseValueDelegate ) {
        self.viewModel = viewModel
        self.chooseDelegate = chooseDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Dimensions.bottomInset)
        }
    }
}

// MARK: - UITableViewDelegate
extension ChooseValueTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            self.chooseDelegate?.valueDidSelected(value: self.viewModel.sourceArray[indexPath.row])
        }
    }
}

// MARK: - UITableViewDataSource
extension ChooseValueTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChooseValueTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.updateWith(entity: viewModel.sourceArray[indexPath.row])
        
        return cell
    }
}
