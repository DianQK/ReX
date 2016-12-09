//
//  Proxy.swift
//  ReX
//
//  Created by wc on 09/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

public protocol Proxy {
    
    associatedtype Base
    
    var base: Base { get }
    
    init(_ base: Base)

}
