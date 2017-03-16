//
//  GridViewHeaderCell.swift
//  SwiftSortableGridView
//
//  Created by Kristijan Kontus on 13/01/2017.
//  Copyright © 2017 com.kkontus. All rights reserved.
//

import UIKit

class GridViewHeaderCell: UICollectionReusableView, CellCreator {
    private let fontSize: CGFloat = 8
    private let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    
    let column1: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let column2: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let column3: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let column4: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let column5: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let column6: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        label.textAlignment = .left
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
        column1.font = UIFont.systemFont(ofSize: fontSize)
        column2.font = UIFont.systemFont(ofSize: fontSize)
        column3.font = UIFont.systemFont(ofSize: fontSize)
        column4.font = UIFont.systemFont(ofSize: fontSize)
        column5.font = UIFont.systemFont(ofSize: fontSize)
        column6.font = UIFont.systemFont(ofSize: fontSize)
        
        column1.textColor = UIColor.headerCellText
        column2.textColor = UIColor.headerCellText
        column3.textColor = UIColor.headerCellText
        column4.textColor = UIColor.headerCellText
        column5.textColor = UIColor.headerCellText
        column6.textColor = UIColor.headerCellText
        
        stackView.axis = UILayoutConstraintAxis.horizontal
        stackView.distribution = UIStackViewDistribution.fillEqually
        stackView.alignment = UIStackViewAlignment.fill
        stackView.spacing = 0.0
        
        stackView.addArrangedSubview(column1)
        stackView.addArrangedSubview(column2)
        stackView.addArrangedSubview(column3)
        stackView.addArrangedSubview(column4)
        stackView.addArrangedSubview(column5)
        stackView.addArrangedSubview(column6)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}

