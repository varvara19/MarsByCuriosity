//
//  ChooseValueTableViewCell.swift
//  MarsByCuriosity
//
//

import UIKit

final class ChooseValueTableViewCell: UITableViewCell {
    private enum Dimensions {
        static let sideSpacing: CGFloat = 12
        static let topInset: CGFloat = 4
        static let leadingInset: CGFloat = 24
    }
    
    private let titleLabel = UILabel(font: .systemFont(ofSize: 16), textColor: .appBlack, textAlignment: .left, numberOfLines: 0)
    private let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.backgroundColor = .cellBackgroundColor
        containerView.layer.cornerRadius = AppConstants.cornerRadius
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubviews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
    }
    
    private func setupConstraint() {
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Dimensions.topInset)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.leadingInset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Dimensions.sideSpacing)
        }
    }
    
    func updateWith(entity: String) {
        titleLabel.text = entity
    }
}
