//
//  TodoItem.swift
//  RxSwiftX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct TodoItem {

    let id: Int64
    var name: String
    var isCompleted: Bool

    init(id: Int64, name: String) {
        self.id = id
        self.name = name
        self.isCompleted = false
    }

}

extension TodoItem: IdentifiableType, Hashable {

    var hashValue: Int {
        return id.hashValue
    }

    var identity: Int64 {
        return id
    }

    static func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
        return lhs.id == rhs.id
    }

}

extension TodoItem: Comparable {

    public static func <(lhs: TodoItem, rhs: TodoItem) -> Bool {
        return lhs.id < rhs.id
    }

}
