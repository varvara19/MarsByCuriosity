//
//  UICollectionView+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T:UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuse_id(), for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuse_id())
    }
}
