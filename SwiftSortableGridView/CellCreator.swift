//
//  CellCreator.swift
//  SwiftSortableGridView
//
//  Created by Kristijan Kontus on 04/01/2017.
//  Copyright © 2017 com.kkontus. All rights reserved.
//

import Foundation

protocol CellCreator {
    func createColumnRange(_ numberOfColumns: Int) -> NSRange
    func createColumnRangeCustom(_ startElement: Int, endElement: Int) -> NSRange
}

extension CellCreator {
    func createColumnRange(_ numberOfColumns: Int) -> NSRange {
        return NSMakeRange(0, numberOfColumns-1)
    }
    
    func createColumnRangeCustom(_ startElement: Int, endElement: Int) -> NSRange {
        return NSMakeRange(startElement, endElement-1)
    }
}
