//
//  FloatingPanelHeaderView.swift
//  MarsByCuriosity
//
//

import UIKit

final class FloatingPanelHeaderView: UIView {
    private enum Dimensions {
        static let sideSpacing: CGFloat = 16
        static let topInset: CGFloat = 8
        static let imageViewHeight: CGFloat = 24.adapted
    }
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel(font: .bold(ofSize: 18), textColor: .appBlack, textAlignment: .center, numberOfLines: 0)
    
    init(title: String, iconName: String) {
        super.init(frame: .zero)
        
        imageView.image = UIImage(named: iconName)
        titleLabel.text = title
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.sideSpacing)
            $0.width.height.equalTo(Dimensions.imageViewHeight)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(Dimensions.topInset)
            $0.leading.trailing.bottom.equalToSuperview().inset(Dimensions.sideSpacing)
        }
    }
}
