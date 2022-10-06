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
        surfaceView.grabberHandle.isHidden = true
        
        layout = MarsByCuriosityFloatingPanelLayout()
        
        isRemovalInteractionEnabled = true
        backdropView.dismissalTapGestureRecognizer.isEnabled = true
        
        contentMode = .fitToBounds
        
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - FloatingPanelControllerDelegate
extension CustomFloatingPanelController: FloatingPanelControllerDelegate {
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        guard fpc.isAttracting == false else { return }
        
        let loc = fpc.surfaceLocation
        
        let minY = fpc.surfaceLocation(for: .full).y - 6.0
        let maxY = fpc.surfaceLocation(for: .tip).y + 6.0
        fpc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
    }
}
