//
//  FilteredList.swift
//  Friends
//
//  Created by Mihai Leonte on 25/11/2019.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import SwiftUI
import CoreData

enum Predicate: String {
    case beginsWith =  "BEGINSWITH"
    case equals = "=="
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (FetchedResults<T>) -> Content

    var body: some View {
//        List(fetchRequest.wrappedValue, id: \.self) { singer in
//            self.content(singer)
//        }
        self.content(fetchRequest.wrappedValue)
    }

    init(predicate: Predicate,
         filterKey: String,
         filterValue: String,
         sortKey: String,
         sortAsc: Bool,
         @ViewBuilder content: @escaping (FetchedResults<T>) -> Content) {
        
        fetchRequest = FetchRequest<T>(entity: T.entity(),
                                       sortDescriptors: [NSSortDescriptor(key: sortKey, ascending: sortAsc)],
                                       predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}
