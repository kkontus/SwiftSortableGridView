//
//  SortableGridView.swift
//  SwiftSortableGridView
//
//  Created by Kristijan Kontus on 04/01/2017.
//  Copyright © 2017 com.kkontus. All rights reserved.
//

protocol SortableGridView : class {
    func sortGridView(_ order: Bool, column: Int, columnName: String?, sortOrderIcon: String?, sortOrderColumn: Int?)
}

extension SortableGridView {
    func sortGridView(_ order: Bool, column: Int, columnName: String?, sortOrderIcon: String?, sortOrderColumn: Int?) {
        
    }
}
