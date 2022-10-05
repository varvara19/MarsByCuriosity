//
//  DashboardViewController.swift
//  MarsByCuriosity
//
//

import UIKit

final class DashboardViewController: CoreViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = LS("DASHBOARD.TITLE")
    }
}
