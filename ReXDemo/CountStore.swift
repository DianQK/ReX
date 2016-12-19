//
//  CountStore.swift
//  RxSwiftX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import ReX
import RxSwift

class CountStore: StoreType {

    class State {
        let count = Variable<Int>(0)
    }

    let state = State()

}

extension Getter where Store: CountStore {

    var count: GetVariable<Int> {
        return store.state.count.asGetVariable()
    }

}

extension Mutation where Store: CountStore {

    func increment() {
        store.state.count.value += 1
    }

}
