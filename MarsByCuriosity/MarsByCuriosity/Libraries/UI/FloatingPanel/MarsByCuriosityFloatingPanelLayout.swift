//
//  MarsByCuriosityFloatingPanelLayout.swift
//  MarsByCuriosity
//
//

import FloatingPanel

final class MarsByCuriosityFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .full
    
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [ .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea), ]
}
