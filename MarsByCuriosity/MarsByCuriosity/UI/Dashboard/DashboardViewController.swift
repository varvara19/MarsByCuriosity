//
//  DashboardViewController.swift
//  MarsByCuriosity
//
//

import UIKit
import SnapKit

final class DashboardViewController: CoreViewController {
    private let imageView = UIImageView(image: UIImage(named: "dashboardImage"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    override func addSubviews() {
        view.addSubview(imageView)
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints { $0.leading.trailing.bottom.equalToSuperview() }
    }

    private func setupNavBar() {
        navigationItem.title = LS("DASHBOARD.TITLE")
    }
}
