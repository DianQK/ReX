//
//  TodoStore.swift
//  RxSwiftX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import ReX
import RxSwift

/// 待办事项 Store
class TodoStore: StoreType {

    fileprivate let todoList = Variable<[TodoItem]>([])

}

extension Getter where Store: TodoStore {

    var completedList: Observable<[TodoItem]> {
        return store.todoList.asObservable()
            .map { $0.filter { $0.isCompleted } }
    }

    var uncompletedList: Observable<[TodoItem]> {
        return store.todoList.asObservable()
            .map { $0.filter { !$0.isCompleted } }
    }

}

extension Mutation where Store: TodoStore {

    var completed: (Int64) -> Void {
        return { [unowned store = self.store] id in
            store.todoList.value = store.todoList.value.map { item in
                var item = item
                if id == item.id {
                    item.isCompleted = true
                }
                return item
            }
        }
    }

    var add: (_ name: String) -> Void {
        return { [unowned store = self.store] name in
            let id = (store.todoList.value.max()?.id ?? 0) + 1
            let todoItem = TodoItem(id: id, name: name)
            store.todoList.value.append(todoItem)
        }
    }

    var delete: (Int64) -> Void {
        return { [unowned store = self.store] id in
            store.todoList.value = store.todoList.value.filter { $0.id != id }
        }
    }

}

extension Action where Store: TodoStore {
    var delete: (Int64) -> Observable<String> {
        return { [unowned store = self.store] id -> Observable<String> in
            store.getter.completedList.take(1)
                .flatMap { completedList -> Observable<String> in
                    guard let item = completedList.filter({ id == $0.id }).first else {
                        return Observable.just("并没有这个代办事项")
                    }
                    return showEnsure("确定删除\(item.name)吗？")
                            .map { id }
                            .do(onNext: store.commit.delete)
                            .map { _ in "删除成功" }
            }
        }
    }
}
