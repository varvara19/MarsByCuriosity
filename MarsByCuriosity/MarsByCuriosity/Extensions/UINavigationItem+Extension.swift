//
//  UINavigationItem+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UINavigationItem {
    enum NavigationTitleType {
        case boldTitle
        case boldDescription
        
        var titleFont: UIFont {
            switch self {
                case .boldTitle:
                    return .bold(ofSize: 18)
                case .boldDescription:
                    return .light(ofSize: 12)
            }
        }
        
        var descriptionFont: UIFont {
            switch self {
                case .boldTitle:
                    return .light(ofSize: 12)
                case .boldDescription:
                    return .bold(ofSize: 18)
            }
        }
        
        var textColor: UIColor {
            switch self {
                case .boldTitle:
                    return .appBlack
                case .boldDescription:
                    return .appWhite
            }
        }
    }
    
    static func setTitle(title:String, subtitle: String, type: NavigationTitleType) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -8, width: 0, height: 0))

        titleLabel.backgroundColor = .clear
        titleLabel.textColor = type.textColor
        titleLabel.font = type.titleFont
        titleLabel.text = title
        titleLabel.sizeToFit()

        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 12, width: 0, height: 0))
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.textColor = type.textColor
        subtitleLabel.font = type.descriptionFont
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: titleLabel.frame.size.width, height: 20))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }

        return titleView
    }
}
