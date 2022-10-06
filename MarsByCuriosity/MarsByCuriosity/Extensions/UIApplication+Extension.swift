//
//  UIApplication+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UIApplication {
    static var rootViewController: RootViewController {
        let rootVC = UIApplication.shared.delegate?.window??.rootViewController as? RootViewController
        if rootVC == nil {
            assert( rootVC != nil, "Root view controller must be derived from CoreViewController")
        }
        
        return rootVC!
    }
    
    static var topPresentedViewController: UIViewController {
        var controller: UIViewController = UIApplication.rootViewController
        
        while controller.presentedViewController != nil {
            controller = controller.presentedViewController!
        }
        
        return controller
    }
    
    static var topNavigationController : UINavigationController? {
        return self.rootViewController.topNavigationController()
    }
    
    static func present(presentVC: UIViewController, on viewController: UIViewController? = nil, completion: (()->())? = nil) {
        let topPresentedVC = viewController ?? topPresentedViewController
        topPresentedVC.present(presentVC, animated: true, completion: completion)
    }
    
    static func push(viewController: UIViewController, navigationController: UINavigationController? = nil) {
        if let navigationController1 = navigationController ?? topNavigationController {
            navigationController1.pushViewController(viewController, animated: true)
        }
    }
}
