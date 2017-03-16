//
//  Data.swift
//  SwiftSortableGridView
//
//  Created by Kristijan Kontus on 06/03/2017.
//  Copyright © 2017 com.kkontus. All rights reserved.
//

public class Data {
    
    static func getGridHeaderColumns() -> [String] {
        var items: [String] = []
        // header
        items.append(ColumnsValuesHelper.columnFirstname)
        items.append(ColumnsValuesHelper.columnLastname)
        items.append(ColumnsValuesHelper.columnAge)
        items.append(ColumnsValuesHelper.columnDateOfBirth)
        items.append(ColumnsValuesHelper.columnAddress)
        items.append(ColumnsValuesHelper.columnEmail)
        
        return items
    }
    
    static func getDataObjects() -> Array<GridDataObject> {
        var dataToSort: Array<GridDataObject> = []
        
        //data
        let gdo1 = GridDataObject()
        gdo1.firstname = "aa11.00"
        gdo1.lastname = "aa22.00"
        gdo1.age = "aa33.00"
        gdo1.dateOfBirth = "aa44.00"
        gdo1.address = "aa55.00"
        gdo1.email = "aa66.00"
        
        
        let gdo2 = GridDataObject()
        gdo2.firstname = "bb11.00"
        gdo2.lastname = "bb22.00"
        gdo2.age = "bb33.00"
        gdo2.dateOfBirth = "bb44.00"
        gdo2.address = "bb55.00"
        gdo2.email = "bb66.00"
        
        
        let gdo3 = GridDataObject()
        gdo3.firstname = "cc11.00"
        gdo3.lastname = "cc22.00"
        gdo3.age = "cc33.00"
        gdo3.dateOfBirth = "cc44.00"
        gdo3.address = "cc55.00"
        gdo3.email = "cc66.00"
        
        
        let gdo4 = GridDataObject()
        gdo4.firstname = "dd11.00"
        gdo4.lastname = "dd22.00"
        gdo4.age = "dd33.00"
        gdo4.dateOfBirth = "dd44.00"
        gdo4.address = "dd55.00"
        gdo4.email = "dd66.00"
        
        
        let gdo5 = GridDataObject()
        gdo5.firstname = "ee11.00"
        gdo5.lastname = "ee22.00"
        gdo5.age = "ee33.00"
        gdo5.dateOfBirth = "ee44.00"
        gdo5.address = "ee55.00"
        gdo5.email = "ee66.00"
        
        
        let gdo6 = GridDataObject()
        gdo6.firstname = "ff11.00"
        gdo6.lastname = "ff22.00"
        gdo6.age = "ff33.00"
        gdo6.dateOfBirth = "ff44.00"
        gdo6.address = "ff55.00"
        gdo6.email = "ff66.00"
        
        let gdo7 = GridDataObject()
        gdo7.firstname = "gg11.00"
        gdo7.lastname = "gg22.00"
        gdo7.age = "gg33.00"
        gdo7.dateOfBirth = "gg44.00"
        gdo7.address = "gg55.00"
        gdo7.email = "gg66.00"
        
        let gdo8 = GridDataObject()
        gdo8.firstname = "hh11.00"
        gdo8.lastname = "hh22.00"
        gdo8.age = "hh33.00"
        gdo8.dateOfBirth = "hh44.00"
        gdo8.address = "hh55.00"
        gdo8.email = "hh66.00"
        
        let gdo9 = GridDataObject()
        gdo9.firstname = "ii11.00"
        gdo9.lastname = "ii22.00"
        gdo9.age = "ii33.00"
        gdo9.dateOfBirth = "ii44.00"
        gdo9.address = "ii55.00"
        gdo9.email = "ii66.00"
        
        let gdo10 = GridDataObject()
        gdo10.firstname = "jj11.00"
        gdo10.lastname = "jj22.00"
        gdo10.age = "jj33.00"
        gdo10.dateOfBirth = "jj44.00"
        gdo10.address = "jj55.00"
        gdo10.email = "jj66.00"
        
        
        dataToSort.append(gdo1)
        dataToSort.append(gdo2)
        dataToSort.append(gdo3)
        dataToSort.append(gdo4)
        dataToSort.append(gdo5)
        dataToSort.append(gdo6)
        dataToSort.append(gdo7)
        dataToSort.append(gdo8)
        dataToSort.append(gdo9)
        dataToSort.append(gdo10)
        
        return dataToSort
    }
    
}
