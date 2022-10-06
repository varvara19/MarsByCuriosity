//
//  TableFooterViewWithActionButton.swift
//  MarsByCuriosity
//
//

import UIKit

final class FooterViewWithActionButton: UIView {
    private enum Dimensions {
        static let topInset: CGFloat = 32
        static let leadingTrailingInset: CGFloat = 24
        static let buttonHeight: CGFloat = 60.adapted
    }
    
    private let title: String
    private let target: AnyObject?
    private let selector: Selector
    private lazy var actionButton = ActionButton(title: title, target: target, action: selector)
    
    init(buttonTitle: String, target: AnyObject?, selector: Selector) {
        self.title = buttonTitle
        self.target = target
        self.selector = selector
        
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        actionButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.topInset)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.leadingTrailingInset)
            $0.height.equalTo(Dimensions.buttonHeight)
            $0.bottom.equalToSuperview()
        }
    }
}
