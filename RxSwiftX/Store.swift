//
//  Store.swift
//  RxSwiftX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import Foundation

public protocol Store {

}

public protocol Proxy {
    associatedtype Base

    var base: Base { get }

    init(_ base: Base)
}

// MARK: - State

public struct State<Base>: Proxy {
    public let base: Base

    public init(_ base: Base) {
        self.base = base
    }
    
}

extension Store {
    public var state: State<Self> {
        return State(self)
    }
}

// MARK: - Getters

public struct Getter<Base>: Proxy {
    public let base: Base

    public init(_ base: Base) {
        self.base = base
    }
}

extension Store {
    public var getters: Getter<Self> {
        return Getter(self)
    }
}

// MARK: - Mutation

public struct Mutation<Base>: Proxy { // 同步的修改数据，对应 commit
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

// MARK: - Action

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
