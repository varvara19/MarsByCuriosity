//
//  RootViewController.swift
//  MarsByCuriosity
//
//

import UIKit

class RootViewController: UIViewController {
    private var childViewController: UIViewController?
    
    static var shared: RootViewController? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.window?.rootViewController as? RootViewController
        }
        return nil
    }
    
    override func loadView() {
        super.loadView()
        
        animationToDashboard()
    }
    
    private func animationToDashboard() {
        let navigationController = UINavigationController(rootViewController: DashboardViewController())
        self.addNewChildViewController(vc:navigationController)
    }
    
    private func addNewChildViewController(vc: UIViewController) {
        self.animation(duration: 0.26, newVC: vc, oldVC: self.childViewController)
        self.childViewController = vc
    }
    
    private func animation(duration: TimeInterval, newVC: UIViewController, oldVC: UIViewController? = nil) {
        
        if let oldVC = oldVC {
            self.addChild(newVC)
            self.view.insertSubview(newVC.view, belowSubview: oldVC.view)
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut) {
                newVC.didMove(toParent: self)
                oldVC.view.alpha = 0.2
                newVC.view.alpha = 1
            } completion: { finished in
                oldVC.willMove(toParent: nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParent()
            }
        } else {
            self.addChild(newVC)
            self.view.addSubview(newVC.view)
            newVC.didMove(toParent: self)
        }
    }
    
    func topViewController() -> UIViewController? {
        return self.childViewController
    }
    
    func topNavigationController() -> UINavigationController? {
        var topNavigationController: UINavigationController?
        
        switch self.topViewController() {
            case let controller as UINavigationController: topNavigationController = controller
            default: break
        }
        return topNavigationController
    }
}

