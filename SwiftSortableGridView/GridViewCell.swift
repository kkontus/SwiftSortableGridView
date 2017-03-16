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
    
    private let sortIcon: UIImageView = {
        let image = UIImage(named: GridConfig.ascending)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addSubview(sortIcon)
        
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        sortIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        sortIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        sortIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        sortIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
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
    
    func setup(_ indexPath: IndexPath, range: NSRange, rangeFooter: NSRange, sortOrderIcon: String?, sortOrderColumn: Int?) {
        if let row = sortOrderColumn {
            if row == indexPath.row {
                let image = UIImage(named: sortOrderIcon!)
                sortIcon.alpha = 1.0
                sortIcon.image = image
            } else {
                sortIcon.alpha = 0.0
            }
        } else {
            sortIcon.alpha = 0.0
        }
        
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
            } else {
                self.backgroundColor = UIColor.sortAppliedCell
                nameLabel.textColor = UIColor.headerCellText
            }
            
            let order = selectSortOrderImageName(sortOrder: sortOrder)
            delegate?.sortGridView(sortOrder, column: indexPath.row, columnName: columnName, sortOrderIcon: order, sortOrderColumn: indexPath.row)
        } else if indexPath.row >= rangeFooter.location && indexPath.row <= rangeFooter.length {
            self.backgroundColor = UIColor.footerCell
            nameLabel.textColor = UIColor.footerCellText
        } else {
            self.backgroundColor = UIColor.dataCell
            nameLabel.textColor = UIColor.dataCellText
        }
    }
    
    private func selectSortOrderImageName(sortOrder: Bool) -> String {
        var order: String
        if sortOrder {
            order = GridConfig.descending
        } else {
            order = GridConfig.ascending
        }
        
        return order
    }
    
}

