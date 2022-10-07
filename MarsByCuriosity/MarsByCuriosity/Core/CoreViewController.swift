//
//  CoreViewController.swift
//  MarsByCuriosity
//
//

import UIKit

class CoreViewController: UIViewController {
    var backgroundColor: UIColor { .backgroundColor }
    var textColor: UIColor { .appBlack }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let navBarImage = UIImage()
        
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appBlack,
                               NSAttributedString.Key.font: UIFont.bold(ofSize: 18)]
        
        view.backgroundColor = backgroundColor
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
        
        UINavigationBar.appearance().tintColor = textColor
        UINavigationBar.appearance().barTintColor = backgroundColor
        UINavigationBar.appearance().titleTextAttributes = titleAttributes
        UINavigationBar.appearance().shadowImage = navBarImage
        UINavigationBar.appearance().isTranslucent = false
        
        guard let navigationController = navigationController else { return }
        
        navigationController.navigationBar.tintColor = textColor
        navigationController.navigationBar.barTintColor = backgroundColor
        navigationController.navigationBar.titleTextAttributes = titleAttributes
        navigationController.navigationBar.shadowImage = navBarImage
        navigationController.navigationBar.isTranslucent = false
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = backgroundColor
            appearance.titleTextAttributes = titleAttributes
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
            navigationController.navigationBar.shadowImage = navBarImage
            navigationController.navigationBar.isTranslucent = false
        }
    }
    
    func addSubviews() { }
    
    func setupConstraints() { }
}
