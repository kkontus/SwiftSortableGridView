//
//  SwiftSortableGridViewV5.swift
//  SwiftSortableGridView
//
//  Created by Kristijan Kontus on 06/01/2017.
//  Copyright © 2017 com.kkontus. All rights reserved.
//

import UIKit

class SwiftSortableGridView: UIView, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, SortableGridView {
    weak var delegate: SortableGridView?
    private var scrollViewHorizontal: UIScrollView!
    private var contentView: UIView!
    private var collectionView: UICollectionView!
    private var cellDescription: [String:[String:String?]] = [:]
    private var items: [String] = []
    // exposed to developer
    var gridColumns: [String] = []
    var gridData: Array<GridDataObject> = []
    var gridCellWidth: CGFloat = 0.0
    var gridCellHeight: CGFloat = 0.0
    var numberOfColumns: Int = 0
    var sortOrder = false
    var sortOrderIcon: String? = GridConfig.defaultOrder // do not translate this, it is an image set name
    var sortOrderColumn: Int? = GridConfig.defaultColumn
    var useStickyHeader: Bool = true
    
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    private func reloadGrid() {
        if collectionView != nil {
            collectionView.reloadData()
        }
    }
    
    func reloadGridData(data: Array<GridDataObject>) {
        items = []
        
        if useStickyHeader == false {
            for columnTitle in gridColumns {
                cellDescription[String(items.count)] = ["columnIndex": String(items.count), "columnName": columnTitle]
                items.append(columnTitle)
            }
        }
        
        for element in data {
            items.append(element.firstname)
            items.append(element.lastname)
            items.append(element.age)
            items.append(element.dateOfBirth)
            items.append(element.address)
            items.append(element.email)
        }
        
        reloadGrid()
    }
    
    func drawGrid() {
        //scrollview
        scrollViewHorizontal = UIScrollView(frame: CGRect.zero)
        scrollViewHorizontal.bounces = false
        scrollViewHorizontal.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollViewHorizontal.backgroundColor = UIColor.scrollViewHorizontalBackgroundColor
        
        //add scrollview to root view
        self.addSubview(scrollViewHorizontal)
        addLayoutConstraintsForHorizontalScrollView(scrollViewHorizontal)
        
        
        //content view inside scrollview
        contentView = UIView(frame: CGRect.zero)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = UIColor.contentViewBackgroundColor
        
        //add content view to scrollview
        scrollViewHorizontal.addSubview(contentView)
        let recalcualatedGridWidth = (self.gridCellWidth * CGFloat(self.numberOfColumns)) - self.frame.width
        addLayoutConstraintsForContentView(contentView, width: recalcualatedGridWidth)
        
        
        //create collection view
        let layout = StickyHeadersCollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        layout.itemSize = CGSize(width: self.gridCellWidth, height: self.gridCellHeight)
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.collectionViewBackgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GridViewCell.self, forCellWithReuseIdentifier: GridViewCell.identifier)
        collectionView.register(GridViewHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GridViewHeaderCell.identifier)
        
        // add collection view to content view
        contentView.addSubview(collectionView)
        addLayoutConstraintsForCollectionView(collectionView)
        
        
        reloadGridData(data: gridData)
    }
    
    // MARK: - UICollectionViewDataSource protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridViewCell.identifier, for: indexPath) as! GridViewCell
        cell.setData(items[indexPath.row])
        
        if cellDescription.index(forKey: String(indexPath.row)) != nil {
            cell.setCellDescription(cellDescription[String(indexPath.row)])
        }
        
        let numberOfItems = items.count
        if useStickyHeader {
            cell.setup(indexPath, range: cell.createColumnRange(0), rangeFooter: cell.createColumnRangeCustom(numberOfItems-numberOfColumns, endElement: numberOfItems), sortOrderIcon: sortOrderIcon, sortOrderColumn: sortOrderColumn)
        } else {
            cell.setup(indexPath, range: cell.createColumnRange(numberOfColumns), rangeFooter: cell.createColumnRangeCustom(numberOfItems-numberOfColumns, endElement: numberOfItems), sortOrderIcon: sortOrderIcon, sortOrderColumn: sortOrderColumn)
        }
        cell.delegate = delegate //we need this so we can sort collection view in controller, not in cell definition class
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Dequeue Reusable Supplementary View
        if let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GridViewHeaderCell.identifier, for: indexPath) as? GridViewHeaderCell {
            // Configure Supplementary View
            supplementaryView.backgroundColor = UIColor.headerCell
            supplementaryView.column1.text = gridColumns[0]
            supplementaryView.column2.text = gridColumns[1]
            supplementaryView.column3.text = gridColumns[2]
            supplementaryView.column4.text = gridColumns[3]
            supplementaryView.column5.text = gridColumns[4]
            supplementaryView.column6.text = gridColumns[5]
            
            return supplementaryView
        }
        
        fatalError("Unable to Dequeue Reusable Supplementary View")
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: GridViewCell = collectionView.cellForItem(at: indexPath)! as! GridViewCell
        
        let numberOfItems = items.count
        
        if useStickyHeader {
            cell.setupHeader(indexPath, range: cell.createColumnRange(0), rangeFooter: cell.createColumnRangeCustom(numberOfItems-numberOfColumns, endElement: numberOfItems), sortOrder: !sortOrder)
        } else {
            cell.setupHeader(indexPath, range: cell.createColumnRange(numberOfColumns), rangeFooter: cell.createColumnRangeCustom(numberOfItems-numberOfColumns, endElement: numberOfItems), sortOrder: !sortOrder)
        }
        
    }
    
    // MARK: - Collection View Delegate Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: self.gridCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if useStickyHeader {
            return CGSize(width: collectionView.bounds.width, height: self.gridCellHeight)
        } else {
            return CGSize.zero
        }
    }
    
    private func addLayoutConstraintsForHorizontalScrollView(_ newItem: UIView) {
        //when using autolayout constraints in the code, we MUST ALWAYS SET translatesAutoresizingMaskIntoConstraints = false
        newItem.translatesAutoresizingMaskIntoConstraints = false
        
        //pin N points from the top of the super
        let topContraint = NSLayoutConstraint(item: newItem, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        
        //pin the view N points from the left edge of the the superview
        //from the left edge of the view to the left edge of the superview
        //superview X coord is at 0 therefore 0 + 20 = 20 position
        let leadingContraint = NSLayoutConstraint(item: newItem, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        
        //pin the view N points from the right edge of the superview
        //negative because we want to pin -N points from the end of the superview.
        //ie., if with of super view is 300, 300-20 = 280 position
        let trailingContraint = NSLayoutConstraint(item: newItem, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0) //use this constant with negative (-N)
        
        //pin N points from the top of the super
        let bottomContraint = NSLayoutConstraint(item: newItem, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        //add the constrains.
        //we pass an array of all the contraints
        self.addConstraints([topContraint, leadingContraint, trailingContraint, bottomContraint])
    }
    
    private func addLayoutConstraintsForContentView(_ newItem: UIView, width: CGFloat) {
        //when using autolayout constraints in the code, we MUST ALWAYS SET translatesAutoresizingMaskIntoConstraints = false
        newItem.translatesAutoresizingMaskIntoConstraints = false
        
        //pin N points from the top of the super
        let topContraint = NSLayoutConstraint(item: newItem, attribute: .top, relatedBy: .equal, toItem: scrollViewHorizontal, attribute: .top, multiplier: 1.0, constant: 0)
        
        //pin the view N points from the left edge of the the superview
        //from the left edge of the view to the left edge of the superview
        //superview X coord is at 0 therefore 0 + 20 = 20 position
        let leadingContraint = NSLayoutConstraint(item: newItem, attribute: .leading, relatedBy: .equal, toItem: scrollViewHorizontal, attribute: .leading, multiplier: 1.0, constant: 0)
        
        //pin the view N points from the right edge of the superview
        //negative because we want to pin -N points from the end of the superview.
        //ie., if with of super view is 300, 300-20 = 280 position
        let trailingContraint = NSLayoutConstraint(item: newItem, attribute: .trailing, relatedBy: .equal, toItem: scrollViewHorizontal, attribute: .trailing, multiplier: 1.0, constant: 0) //use this constant with negative (-N)
        
        //pin N points from the top of the super
        let bottomContraint = NSLayoutConstraint(item: newItem, attribute: .bottom, relatedBy: .equal, toItem: scrollViewHorizontal, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        //width and height constraints
        let widthConstraint = NSLayoutConstraint(item: newItem, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: self.frame.width + width)
        let heightConstraint = NSLayoutConstraint(item: newItem, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: self.frame.height)
        
        //add the constrains.
        //we pass an array of all the contraints
        scrollViewHorizontal.addConstraints([topContraint, leadingContraint, trailingContraint, bottomContraint, widthConstraint, heightConstraint])
    }
    
    private func addLayoutConstraintsForCollectionView(_ newItem: UIView) {
        //when using autolayout constraints in the code, we MUST ALWAYS SET translatesAutoresizingMaskIntoConstraints = false
        newItem.translatesAutoresizingMaskIntoConstraints = false
        
        //pin N points from the top of the super
        let topContraint = NSLayoutConstraint(item: newItem, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0)
        
        //pin the view N points from the left edge of the the superview
        //from the left edge of the view to the left edge of the superview
        //superview X coord is at 0 therefore 0 + 20 = 20 position
        let leadingContraint = NSLayoutConstraint(item: newItem, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0)
        
        //pin the view N points from the right edge of the superview
        //negative because we want to pin -N points from the end of the superview.
        //ie., if with of super view is 300, 300-20 = 280 position
        let trailingContraint = NSLayoutConstraint(item: newItem, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0) //use this constant with negative (-N)
        
        //pin N points from the top of the super
        let bottomContraint = NSLayoutConstraint(item: newItem, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        //add the constrains.
        //we pass an array of all the contraints
        contentView.addConstraints([topContraint, leadingContraint, trailingContraint, bottomContraint])
    }
    
}

