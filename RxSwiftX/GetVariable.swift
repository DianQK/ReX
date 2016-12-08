//
//  GetVariable.swift
//  RxSwiftX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import RxSwift

public class GetVariable<Element> {

    public typealias E = Element

    private let _variable: Variable<Element>

    init(_ variable: Variable<Element>) {
        self._variable = variable
    }

    public var value: E {
        return _variable.value
    }

    public func asObservable() -> Observable<E> {
        return _variable.asObservable()
    }

}

extension Variable {
    public func asGetVariable() -> GetVariable<E> {
        return GetVariable(self)
    }
}
