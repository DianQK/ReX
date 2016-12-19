//
//  Store.swift
//  ReX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

public protocol StoreType: class {

    associatedtype State

    var state: State { get }

}
