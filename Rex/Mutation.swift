//
//  Mutation.swift
//  ReX
//
//  Created by wc on 09/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

public struct Mutation<Base>: Proxy {

    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }

}

extension Store {
    
    public var commit: Mutation<Self> {
        return Mutation(self)
    }
    
}
