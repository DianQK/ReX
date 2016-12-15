//
//  Plugin.swift
//  ReX
//
//  Created by qing on 2016/12/10.
//  Copyright © 2016年 T. All rights reserved.
//

public struct Plugin<Store: StoreType>: StoreProxyType {

    public let store: Store

    public init(_ store: Store) {
        self.store = store
    }

}

public typealias StateHandler<Store: StoreType> = ((State<Store>) -> Void)
public typealias GetterHandler<Store: StoreType> = ((Getter<Store>) -> Void)
public typealias MutationHandler<Store: StoreType> = ((Mutation<Store>) -> Void)
public typealias ActionHandler<Store: StoreType> = ((Action<Store>) -> Void)

public protocol PluginType {

    associatedtype Store: StoreType

    var state: StateHandler<Store>? { get }
    var getter: GetterHandler<Store>? { get }
    var mutation: MutationHandler<Store>? { get }
    var action: ActionHandler<Store>? { get }

}

public struct BasePlugin<Store: StoreType>: PluginType {

    public let state: StateHandler<Store>?
    public let getter: GetterHandler<Store>?
    public let mutation: MutationHandler<Store>?
    public let action: ActionHandler<Store>?

    public init(
        state: StateHandler<Store>? = nil,
        getter: GetterHandler<Store>? = nil,
        mutation: MutationHandler<Store>? = nil,
        action: ActionHandler<Store>? = nil
        ) {
        self.state = state
        self.getter = getter
        self.mutation = mutation
        self.action = action
    }

}

extension StoreType {

    public var plugin: Plugin<Self> {
        return Plugin(self)
    }
    
}

extension Plugin {

    public func use<P: PluginType>(_ plugin: P) where P.Store == Store {
        plugin.state?(store.state)
        plugin.getter?(store.getter)
        plugin.mutation?(store.commit)
        plugin.action?(store.dispatch)
    }

    @discardableResult
    public func use(
        state: StateHandler<Store>? = nil,
        getter: GetterHandler<Store>? = nil,
        mutation: MutationHandler<Store>? = nil,
        action: ActionHandler<Store>? = nil
        ) -> BasePlugin<Store> {
        let plugin = BasePlugin<Store>(state: state, getter: getter, mutation: mutation, action: action)
        use(plugin)
        return plugin
    }

}
