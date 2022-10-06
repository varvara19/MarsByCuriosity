//
//  UITableView+Extension.swift
//  MarsByCuriosity
//
//

import UIKit

extension UITableView {
    convenience init(style: UITableView.Style = .plain, delegate: (UITableViewDelegate & UITableViewDataSource)?, backgroundColor: UIColor = .clear) {
        self.init(frame: .zero, style: style)
        self.clipsToBounds = true
        
        if style == .plain {
            self.tableFooterView = UIView()
        }
        
        self.backgroundColor = backgroundColor
        
        if delegate != nil {
            self.delegate = delegate
            self.dataSource = delegate
        }
        
        autolayoutCells(true)
    }
    
    func autolayoutCells(_ autolayoutCells: Bool, autolayoutHeaders: Bool = false, autolayoutFooter: Bool = false) {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 48;
        
        if autolayoutHeaders {
            sectionHeaderHeight = rowHeight;
            estimatedSectionHeaderHeight = estimatedRowHeight;
        }
        
        if autolayoutFooter {
            sectionFooterHeight = rowHeight;
            estimatedSectionFooterHeight = estimatedRowHeight;
        }
    }
    
    func registerCell<T:UITableViewCell>(_ cellClass:T.Type) {
        let cellId = cellClass.reuse_id()
        self.register(cellClass.self, forCellReuseIdentifier: cellId)
    }
    
    func dequeueReusableCell<T:UITableViewCell> (for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuse_id(), for: indexPath) as! T
    }
}
