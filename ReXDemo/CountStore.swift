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

    fileprivate let count = Variable<Int>(0)

}

extension State where Store: CountStore {

    var count: GetVariable<Int> {
        return store.count.asGetVariable()
    }

}

extension Mutation where Store: CountStore {

    func increment() {
        store.count.value += 1
    }

}
