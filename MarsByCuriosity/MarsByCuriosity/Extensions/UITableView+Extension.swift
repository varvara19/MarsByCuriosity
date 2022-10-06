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
    
    func setAndLayoutTableFooterView(footer: UIView?) {
        self.tableFooterView = footer
        
        guard let footer = footer else { return }
        
        footer.setNeedsLayout()
        footer.layoutIfNeeded()
        
        let sizeFitting = footer.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))

        let height = sizeFitting.height
        let width = sizeFitting.width
        footer.frame.size = CGSize(width: width, height: height)
        self.tableFooterView = footer
    }
    
    func setAndLayoutTableHeaderView(header: UIView?) {
        self.tableHeaderView = header
        
        guard let header = header else { return }
        
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
        self.tableHeaderView = header
    }
}
