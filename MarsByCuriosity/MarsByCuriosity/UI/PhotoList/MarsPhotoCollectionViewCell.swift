//
//  MarsPhotoCollectionViewCell.swift
//  MarsByCuriosity
//
//

import UIKit

final class MarsPhotoCollectionViewCell: UICollectionViewCell {
    private let marsPhotoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
        generalSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        marsPhotoImageView.image = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(marsPhotoImageView)
    }
    
    private func setupConstraints() {
        marsPhotoImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func generalSetup() {
        marsPhotoImageView.layer.masksToBounds = true
        marsPhotoImageView.layer.cornerRadius = AppConstants.cornerRadius
        marsPhotoImageView.backgroundColor = .cellBackgroundColor
    }
    
    func updateWith(entity: Photo) {
        if let image = entity.image {
            marsPhotoImageView.image = image
        } else if let imageUrlString = entity.imgSrc {
            marsPhotoImageView.downloaded(from: imageUrlString) { image in
                entity.image = image
            }
        }
    }
}
