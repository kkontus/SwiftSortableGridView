//
//  GridViewCell.swift
//  SwiftSortableGridView
//
//  Created by Kristijan Kontus on 04/01/2017.
//  Copyright © 2017 com.kkontus. All rights reserved.
//

import UIKit

class GridViewCell: UICollectionViewCell, CellCreator {
    weak var delegate: SortableGridView?
    private let fontSize: CGFloat = 8
    private var columnName: String?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    class var identifier: String {
        return String.className(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        nameLabel.font = UIFont.systemFont(ofSize: fontSize)
        
        addSubview(nameLabel)
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func setData(_ data: Any?) {
        if let menuText = data as? String {
            nameLabel.text = menuText
        }
    }
    
    func setCellDescription(_ data: Any?) {
        if let cellDescription = data as? Dictionary<String, String?> {
            if cellDescription.index(forKey: "columnName") != nil  {
                columnName = cellDescription["columnName"]!
            } else {
                columnName = nil
            }
        }
    }
    
    func setup(_ indexPath: IndexPath, range: NSRange, rangeFooter: NSRange) {
        if indexPath.row >= range.location && indexPath.row <= range.length {
            self.backgroundColor = UIColor.headerCell
            nameLabel.textColor = UIColor.headerCellText
            nameLabel.font = UIFont.systemFont(ofSize: fontSize)
        } else if indexPath.row >= rangeFooter.location && indexPath.row <= rangeFooter.length {
            self.backgroundColor = UIColor.footerCell
            nameLabel.textColor = UIColor.footerCellText
            nameLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        } else {
            self.backgroundColor = UIColor.dataCell
            nameLabel.textColor = UIColor.dataCellText
            nameLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    func setupHeader(_ indexPath: IndexPath, range: NSRange, rangeFooter: NSRange, sortOrder: Bool) {
        if indexPath.row >= range.location && indexPath.row <= range.length {
            if self.backgroundColor == UIColor.sortAppliedCell {
                self.backgroundColor = UIColor.headerCell
                nameLabel.textColor = UIColor.headerCellText
                
                delegate?.sortGridView(sortOrder, column: indexPath.row, columnName: columnName)
            } else {
                self.backgroundColor = UIColor.sortAppliedCell
                nameLabel.textColor = UIColor.headerCellText
                
                delegate?.sortGridView(sortOrder, column: indexPath.row, columnName: columnName)
            }
        } else if indexPath.row >= rangeFooter.location && indexPath.row <= rangeFooter.length {
            self.backgroundColor = UIColor.footerCell
            nameLabel.textColor = UIColor.footerCellText
        } else {
            self.backgroundColor = UIColor.dataCell
            nameLabel.textColor = UIColor.dataCellText
        }
    }
    
}

