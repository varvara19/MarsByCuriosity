//
//  CoreHUD.swift
//  MarsByCuriosity
//
//

import UIKit
import SnapKit
import Lottie

final class AppHUD {
    static var shared = AppHUD()
    
    init() { }
    
    var lastContainer: UIView?
    var lastHUD: AnimationView?
    
    var animationDuration = AppConstants.animationDuration
    var backgroundColor = UIColor.hudBackgroundColor.withAlphaComponent(0.3)
    
    var hud: AnimationView {
        let animationView = AnimationView(name: "loader")
        animationView.loopMode = .loop
        animationView.snp.makeConstraints { $0.width.height.equalTo(200.adapted) }
        return animationView
    }
    
    static func show() {
        guard let window = UIApplication.shared.delegate!.window else { return }
        
        if let lastContainer = shared.lastContainer,
           shared.lastHUD != nil,
           let superview = lastContainer.superview {
            window?.bringSubviewToFront(superview)
        } else {
            let container = UIView(backgroundColor: .clear, frame: .zero)
            let backgroundView = UIView(backgroundColor: shared.backgroundColor, frame: .zero)
            let hud = shared.hud
            
            window?.addSubview(container)
            container.addSubview(backgroundView)
            container.addSubview(hud)
            
            container.snp.makeConstraints { $0.edges.equalToSuperview() }
            backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
            hud.snp.makeConstraints { $0.center.equalToSuperview() }
            
            hud.play()
            
            shared.lastContainer = container
            shared.lastHUD = hud
        }
    }
    
    static func hide() {
        UIView.animate(withDuration: shared.animationDuration) {
            shared.lastContainer?.alpha = 0
        } completion: { isFinished in
            guard isFinished else { return }
            
            shared.lastHUD?.stop()
            shared.lastContainer?.removeFromSuperview()
            
            shared.lastHUD = nil
            shared.lastContainer = nil
        }
    }
}
