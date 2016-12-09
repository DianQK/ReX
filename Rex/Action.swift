//
//  Action.swift
//  ReX
//
//  Created by wc on 09/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

public struct Action<Base>: Proxy {

    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }

}

extension Store {
    
    public var dispatch: Action<Self> {
        return Action(self)
    }
    
}
