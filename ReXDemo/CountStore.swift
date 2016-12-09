//
//  CountStore.swift
//  RxSwiftX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import ReX
import RxSwift

class CountStore: Store {

    fileprivate let count = Variable<Int>(0)

}

extension State where Base: CountStore {

    var count: GetVariable<Int> {
        return base.count.asGetVariable()
    }

}

extension Mutation where Base: CountStore {

    func increment() {
        base.count.value += 1
    }

}
