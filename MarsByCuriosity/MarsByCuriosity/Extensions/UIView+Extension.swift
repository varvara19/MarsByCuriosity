//
//  UIView+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UIView {
    convenience init(backgroundColor: UIColor? = UIColor.clear, frame: CGRect = .zero) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
    }
    
    func set(cornerRadius: CGFloat, roundingCorners: CACornerMask, roundedRect: CGRect? = nil) {
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = roundingCorners
    }
    
    func setMasked(cornerRadius: CGFloat, roundingCorners: UIRectCorner, roundedRect: CGRect? = nil) {
        let path = UIBezierPath(roundedRect: roundedRect ?? bounds,
                                byRoundingCorners: roundingCorners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

// ReuseIdProtocol
public protocol ReuseIdProtocol : NSObjectProtocol {
    static func reuse_id() -> String
}

// MARK: - ReuseIdProtocol
extension UIView: ReuseIdProtocol {
    public static func reuse_id() -> String {
        return typeName(self)
    }
}

public func typeName(_ some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}

// MARK: - AssociatedKeys
extension UIView {
    private struct AssociatedKeys {
        static var INDEX_PATH_KEY = "INDEX_PATH_KEY"
    }
    
    @objc open var indexPath: IndexPath? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.INDEX_PATH_KEY) as? IndexPath }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.INDEX_PATH_KEY,
                                     newValue as NSIndexPath?,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: - Animation
extension UIView {
    private enum Constants {
        static let animationDuration: TimeInterval = 0.5
        static let delay:  TimeInterval = 0
        static let usingSpringWithDamping: CGFloat = 0.20
        static let initialSpringVelocity: CGFloat = 3.0
        static let affineTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.97, y: 0.97)
    }
    
    func scaleUpWithBouncing() {
        UIView.animate(withDuration: Constants.animationDuration,
                       delay: Constants.delay,
                       usingSpringWithDamping: Constants.usingSpringWithDamping,
                       initialSpringVelocity: Constants.initialSpringVelocity,
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: { self.transform = Constants.affineTransform },
                       completion: { _ in })
    }
    
    func scaleDownWithBouncing(duration: TimeInterval = Constants.animationDuration) {
        UIView.animate(withDuration: duration,
                       delay: Constants.delay,
                       usingSpringWithDamping: Constants.usingSpringWithDamping,
                       initialSpringVelocity: Constants.initialSpringVelocity,
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: { self.transform = CGAffineTransform.identity },
                       completion: { _ in })
    }
}
