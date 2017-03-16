//
//  ViewController.swift
//  SwiftSortableGridView
//
//  Created by Kristijan Kontus on 04/01/2017.
//  Copyright © 2017 com.kkontus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SortableGridView {
    var swiftSortableGridView: SwiftSortableGridView!
    private var sortOrder = false
    private var gridData: Array<GridDataObject> = []
    private var sortOrderIcon: String? = GridConfig.defaultOrder // do not change this, it is an image set name
    private var sortOrderColumn: Int? = GridConfig.defaultColumn
    
    // Redraw Collection View if Orientation change occurrs
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil, completion: { _ in
            //self.swiftSortableGridView.frame = CGRect(x: 0, y: 50, width: 320, height: 250)
            self.swiftSortableGridView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 250)
            //self.swiftSortableGridView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            //self.swiftSortableGridView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            if UIDevice.current.orientation.isLandscape {
                print("Landscape")
                print(self.view.frame.width)
            } else {
                print("Portrait")
                print(self.view.frame.width)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        
        createGridView()
    }
    
    func createGridView() {
        swiftSortableGridView = SwiftSortableGridView()
        swiftSortableGridView.delegate = self
        //swiftSortableGridView.frame = CGRect(x: 0, y: 50, width: 320, height: 250)
        swiftSortableGridView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 250)
        //swiftSortableGridView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        //swiftSortableGridView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        // set grid data
        let gridHeaderColumns: [String] = Data.getGridHeaderColumns()
        gridData = Data.getDataObjects()
        
        swiftSortableGridView.gridColumns = gridHeaderColumns
        swiftSortableGridView.gridData = gridData
        
        // set grid data default sorting
        swiftSortableGridView.sortOrderIcon = sortOrderIcon
        swiftSortableGridView.sortOrderColumn = sortOrderColumn
        
        // set grid options
        swiftSortableGridView.numberOfColumns = 6
        swiftSortableGridView.gridCellWidth = 100.0
        swiftSortableGridView.gridCellHeight = 30.0
        
        // draw grid
        swiftSortableGridView.useStickyHeader = false
        swiftSortableGridView.drawGrid()
        
        // add grid to view
        self.view.addSubview(swiftSortableGridView)
    }
    
    func sortGridView(_ order: Bool, column: Int, columnName: String?, sortOrderIcon: String?, sortOrderColumn: Int?) {
        var sortedArray: Array<GridDataObject> = []
        
        self.sortOrderIcon = sortOrderIcon
        self.sortOrderColumn = sortOrderColumn
        
        if order {
            self.sortOrder = true
            
            if columnName == ColumnsValuesHelper.columnFirstname {
                sortedArray = gridData.sorted(by: { $0.firstname > $1.firstname })
            } else if columnName == ColumnsValuesHelper.columnLastname {
                sortedArray = gridData.sorted(by: { $0.lastname > $1.lastname })
            } else if columnName == ColumnsValuesHelper.columnAge {
                sortedArray = gridData.sorted(by: { $0.age > $1.age })
            } else if columnName == ColumnsValuesHelper.columnDateOfBirth {
                sortedArray = gridData.sorted(by: { $0.dateOfBirth > $1.dateOfBirth })
            } else if columnName == ColumnsValuesHelper.columnAddress {
                sortedArray = gridData.sorted(by: { $0.address > $1.address })
            } else if columnName == ColumnsValuesHelper.columnEmail {
                sortedArray = gridData.sorted(by: { $0.email > $1.email })
            }
        } else {
            self.sortOrder = false
            
            if columnName == ColumnsValuesHelper.columnFirstname {
                sortedArray = gridData.sorted(by: { $0.firstname < $1.firstname })
            } else if columnName == ColumnsValuesHelper.columnLastname {
                sortedArray = gridData.sorted(by: { $0.lastname < $1.lastname })
            } else if columnName == ColumnsValuesHelper.columnAge {
                sortedArray = gridData.sorted(by: { $0.age < $1.age })
            } else if columnName == ColumnsValuesHelper.columnDateOfBirth {
                sortedArray = gridData.sorted(by: { $0.dateOfBirth < $1.dateOfBirth })
            } else if columnName == ColumnsValuesHelper.columnAddress {
                sortedArray = gridData.sorted(by: { $0.address < $1.address })
            } else if columnName == ColumnsValuesHelper.columnEmail {
                sortedArray = gridData.sorted(by: { $0.email < $1.email })
            }
        }
        
        self.swiftSortableGridView.gridData = sortedArray
        self.swiftSortableGridView.sortOrder = self.sortOrder
        self.swiftSortableGridView.sortOrderIcon = self.sortOrderIcon
        self.swiftSortableGridView.sortOrderColumn = self.sortOrderColumn
        self.swiftSortableGridView.reloadGridData(data: sortedArray)
    }
    
}

