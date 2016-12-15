//
//  Proxy.swift
//  ReX
//
//  Created by wc on 09/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

public protocol StoreProxyType {
    
    associatedtype Store: StoreType
    
    var store: Store { get }
    
    init(_ store: Store)

}
