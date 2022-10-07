//
//  ActionButton.swift
//  MarsByCuriosity
//
//

import Foundation
import UIKit

final class ActionButton: UIButton {
    enum Dimensions {
        static let titleEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    var action: Selector
    
    weak var target: AnyObject?
    
    init(title: String, target: AnyObject?, action: Selector) {
        self.target = target
        self.action = action
        
        super.init(frame: .zero)
        
        configButton(with: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        scaleUpWithBouncing()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        scaleDownWithBouncing()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        scaleDownWithBouncing()
    }
    
    
    private func configButton(with title: String) {
        backgroundColor = .appRed
        layer.cornerRadius = AppConstants.cornerRadius
        
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        
        clipsToBounds = true
        
        titleLabel?.font = .bold(ofSize: 18)
        titleLabel?.textAlignment = .center
        titleEdgeInsets = Dimensions.titleEdgeInset
        
        setTitle(title, for: .normal)
        
        setTitleColor(.appWhite, for: .normal)
        setTitleColor(.appWhite, for: .highlighted)
        
        switch self.state {
            case .highlighted:
                self.backgroundColor = .appRed.withAlphaComponent(0.4)
            default:
                self.backgroundColor = .appRed
        }
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap(_ tap: UITapGestureRecognizer) {
        _ = target?.perform(action, with: tap.view)
    }
}
