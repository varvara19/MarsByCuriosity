//
//  AlertManager.swift
//  MarsByCuriosity
//
//

import UIKit

final class AlertManager {
    static var shared = AlertManager()
    
    init() { }
    
    var errorTitle          : String { return LS("ERROR") }
    var attentionTitle      : String { return LS("ATTENTION") }
    var continueButtonTitle : String { return LS("CONTINUE") }
    var cancelButtonTitle   : String { return LS("CANCEL") }
    
    static func showAlert(title: String?, message: String?, button: String? = nil, action:(()->())? = nil) {
        shared.showAlert(title: title, message: message, button: button, action: action)
    }
    
    static func showError(_ message: String?, action:(()->())? = nil) {
        shared.showError(message, action: action)
    }
    
    static func showAttention(_ message: String?, action:(()->())? = nil) {
        shared.showAlert(title: shared.attentionTitle, message: message, action: action)
    }
    
    static func showAlert(title: String?, message: String?, buttons:[String], preferredButton:Int? = nil, viewController:UIViewController? = nil, isDismissEqualToCompletion: Bool = true, completion:((Int)->())? = nil) {
        shared.showAlert(title: title, message: message, buttons: buttons, preferredButton: preferredButton, viewController: viewController, isDismissEqualToCompletion: isDismissEqualToCompletion, completion: completion)
    }
    
    static func present(alert: UIViewController, on viewController: UIViewController? = nil) {
        shared.present(alert: alert, on: viewController)
    }
    
    static func showFailureAlert(message: String?, action: (()->())? = nil) {
        shared.showError(message, action: action)
    }
    
    func showAlert(title: String?, message: String?, button: String? = nil, action:(()->())? = nil) {
        let buttonTitle = (button ?? "").isEmpty ? self.continueButtonTitle : button!
        
        self.showAlert(title: title, message: message, buttons: [buttonTitle]) { (selectedIndex) in
            action?()
        }
    }
    
    
    func showError(_ message: String?, action:(()->())? = nil) {
        self.showAlert(title: self.errorTitle,
                       message: message,
                       action: action)
    }
    
    func showAttention(_ message: String?, action:(()->())? = nil) {
        self.showAlert(title: self.attentionTitle,
                       message: message,
                       action: action)
    }
    
    func showAlert(title: String?,
                   message: String?,
                   buttons:[String],
                   preferredButton:Int? = nil,
                   viewController:UIViewController? = nil,
                   isDismissEqualToCompletion: Bool = true,
                   needBlockInteractiveDismiss: Bool = false,
                   completion:((Int)->())? = nil) {
        let title = title ?? self.attentionTitle
        var controller = viewController ?? UIApplication.rootViewController
        
        while controller.presentedViewController != nil { controller = controller.presentedViewController! }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:.alert)
        var preferredAction : UIAlertAction? = nil
        
        for (index, button) in buttons.enumerated() {
            let action = UIAlertAction(title: button, style: .default) { _ in
                completion?(index)
            }
            alert.addAction(action)
            
            if let preferredButton = preferredButton,
               index == preferredButton {
                preferredAction = action
            }
        }
        
        alert.preferredAction = preferredAction
        
        DispatchQueue.main.async {
            controller.present(alert, animated: true)
        }
    }
    
    func present(alert: UIViewController, on viewController: UIViewController? = nil) {
        var controller = viewController ?? UIApplication.rootViewController
        
        while controller.presentedViewController != nil { controller = controller.presentedViewController! }
        
        controller.present(alert, animated: true)
    }
}
