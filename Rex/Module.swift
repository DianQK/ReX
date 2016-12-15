//
//  Module.swift
//  ReX
//
//  Created by qing on 2016/12/15.
//  Copyright © 2016年 T. All rights reserved.
//

public struct Module<Store: StoreType>: StoreProxyType {

    public let store: Store

    public init(_ store: Store) {
        self.store = store
    }
    
}

extension StoreType {

    public var module: Module<Self> {
        return Module(self)
    }

}
