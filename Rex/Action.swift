//
//  Action.swift
//  ReX
//
//  Created by wc on 09/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

public struct Action<Store: StoreType>: StoreProxyType {

    public let store: Store
    
    public init(_ store: Store) {
        self.store = store
    }

}

extension StoreType {
    
    public var dispatch: Action<Self> {
        return Action(self)
    }
    
}
