//
//  UIImageView+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UIImageView {
    func downloaded(from link: String, completion: (() -> ())? = nil) {
        guard let url = URL(string: link) else { return }
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async { [weak self] in
                self?.image = image
                completion?()
            }
        }
    }
}
