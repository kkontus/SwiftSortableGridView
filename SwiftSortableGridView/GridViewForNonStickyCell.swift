//
//  GridViewForNonStickyCell.swift
//  SwiftSortableGridView
//
//  Created by Kristijan Kontus on 16/03/2017.
//  Copyright © 2017 com.kkontus. All rights reserved.
//

import UIKit

class GridViewForNonStickyCell: GridViewCell {
    
    private let sortIcon: UIImageView = {
        let image = UIImage(named: GridConfig.ascending)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override class var identifier: String {
        return String.className(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(sortIcon)
        
        sortIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        sortIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        sortIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        sortIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func setup(_ indexPath: IndexPath, range: NSRange, rangeFooter: NSRange, sortOrderIcon: String?, sortOrderColumn: Int?) {
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
        
        super.setup(indexPath, range: range, rangeFooter: rangeFooter, sortOrderIcon: sortOrderIcon, sortOrderColumn: sortOrderColumn)
    }
    
}

