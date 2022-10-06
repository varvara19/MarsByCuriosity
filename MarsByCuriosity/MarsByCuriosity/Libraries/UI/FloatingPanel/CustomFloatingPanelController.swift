//
//  CustomFloatingPanelController.swift
//  MarsByCuriosity
//
//

import FloatingPanel

final class CustomFloatingPanelController: FloatingPanelController {
    init() {
        super.init(delegate: .none)
        
        let appearance = SurfaceAppearance()

        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: 16)
        shadow.radius = AppConstants.cornerRadius
        shadow.spread = 8
        appearance.shadows = [shadow]

        appearance.cornerRadius = AppConstants.cornerRadius
        appearance.backgroundColor = .clear

        surfaceView.appearance = appearance
        
        layout = MarsByCuriosityFloatingPanelLayout()
        
        isRemovalInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
