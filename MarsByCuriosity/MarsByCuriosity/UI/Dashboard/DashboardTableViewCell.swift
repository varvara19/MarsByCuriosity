//
//  DashboardTableViewCell.swift
//  MarsByCuriosity
//
//

import UIKit

final class DashboardTableViewCell: UITableViewCell {
    private enum Dimensions {
        static let leadingInset: CGFloat = 24
        static let iconSize: CGFloat = 24
        static let iconTrailingInset: CGFloat = 12
        static let topBottomInset: CGFloat = 8
        static let valueLabelInset: CGFloat = 18
        static let containerViewTopInset: CGFloat = 7
    }
    
    private let titleLabel = UILabel(font: .system(ofSize: 14), textColor: .appBlack, textAlignment: .left, numberOfLines: 0)
    
    private let containerView = UIView()
    private let iconTypeImageView = UIImageView()
    private let valueLabel = UILabel(font: .system(ofSize: 18), textColor: .appBlack, textAlignment: .left, numberOfLines: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        generalSetup()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        
        containerView.addSubview(valueLabel)
        containerView.addSubview(iconTypeImageView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.topBottomInset)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.leadingInset)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Dimensions.containerViewTopInset)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.leadingInset)
            $0.bottom.equalToSuperview().inset(Dimensions.topBottomInset)
        }
        
        valueLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Dimensions.valueLabelInset)
            $0.trailing.equalTo(iconTypeImageView.snp.leading)
        }
        
        iconTypeImageView.snp.makeConstraints {
            $0.centerY.equalTo(valueLabel)
            $0.trailing.equalToSuperview().inset(Dimensions.iconTrailingInset)
            $0.height.width.equalTo(Dimensions.iconSize)
        }
    }
    
    private func generalSetup() {
        containerView.backgroundColor = .cellBackgroundColor
        containerView.layer.cornerRadius = 10
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func updateWith(entity: DashboardTableViewCellViewModel) {
        titleLabel.text = entity.title
        valueLabel.text = entity.defaultValue

        iconTypeImageView.image = UIImage(named: entity.type.iconName)
    }
}
