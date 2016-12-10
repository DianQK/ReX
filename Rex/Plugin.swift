//
//  Plugin.swift
//  ReX
//
//  Created by qing on 2016/12/10.
//  Copyright © 2016年 T. All rights reserved.
//

public struct PluginProxy<Base>: Proxy {

    public let base: Base

    public init(_ base: Base) {
        self.base = base
    }

}

public typealias StateHandler<S: Store> = ((State<S>) -> Void)
public typealias GetterHandler<S: Store> = ((Getter<S>) -> Void)
public typealias MutationHandler<S: Store> = ((Mutation<S>) -> Void)
public typealias ActionHandler<S: Store> = ((Action<S>) -> Void)

public protocol PluginProtocol {

    associatedtype S: Store

    var state: StateHandler<S>? { get }
    var getter: GetterHandler<S>? { get }
    var mutation: MutationHandler<S>? { get }
    var action: ActionHandler<S>? { get }

}

public struct BasePlugin<S: Store>: PluginProtocol {

    public let state: StateHandler<S>?
    public let getter: GetterHandler<S>?
    public let mutation: MutationHandler<S>?
    public let action: ActionHandler<S>?

    public init(
        state: StateHandler<S>? = nil,
        getter: GetterHandler<S>? = nil,
        mutation: MutationHandler<S>? = nil,
        action: ActionHandler<S>? = nil
        ) {
        self.state = state
        self.getter = getter
        self.mutation = mutation
        self.action = action
    }

}

extension Store {

    public var plugin: PluginProxy<Self> {
        return PluginProxy(self)
    }
    
}

extension PluginProxy where Base: Store {

    public typealias S = Base

    public func use<P: PluginProtocol>(_ plugin: P) where P.S == Base {
        plugin.state?(base.state)
        plugin.getter?(base.getters)
        plugin.mutation?(base.commit)
        plugin.action?(base.dispatch)
    }

    @discardableResult
    public func use(
        state: StateHandler<S>? = nil,
        getter: GetterHandler<S>? = nil,
        mutation: MutationHandler<S>? = nil,
        action: ActionHandler<S>? = nil
        ) -> BasePlugin<S> {
        let plugin = BasePlugin<S>(state: state, getter: getter, mutation: mutation, action: action)
        use(plugin)
        return plugin
    }

}
