//
//  DashboardViewController.swift
//  MarsByCuriosity
//
//

import UIKit
import SnapKit

final class DashboardViewController: CoreViewController {
    private let imageView = UIImageView(image: UIImage(named: "dashboardImage"))
    private lazy var viewModel = DashboardViewModel(delegate: self)
    
    private lazy var footerView = FooterViewWithActionButton(buttonTitle: LS("EXPLORE.BUTTON.TITLE"), target: self, selector: #selector(didClickActionButton))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = true
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(DashboardTableViewCell.self)
        tableView.setAndLayoutTableFooterView(footer: footerView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let tableViewHeight = self.tableView.frame.height
        
        // size of table + inset from table to button + button height
        let contentHeight: CGFloat = tableView.contentSize.height  + 40 + 60.adapted

        let headerHeight: CGFloat = (tableViewHeight - contentHeight) / 2
        tableView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
    }
    
    override func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        imageView.snp.makeConstraints { $0.leading.trailing.bottom.equalToSuperview() }
    }
    
    private func setupNavBar() {
        navigationItem.title = LS("DASHBOARD.TITLE")
    }
    
    @objc private func didClickActionButton() {
        viewModel.didClickActionButton()
    }
}

// MARK: - UITableViewDelegate
extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DashboardTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.updateWith(entity: viewModel.sourceArray[indexPath.row])
        
        return cell
    }
}

// MARK: - DashboardViewModelDelegate
extension DashboardViewController: DashboardViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
