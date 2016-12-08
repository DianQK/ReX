//
//  TodoStore.swift
//  RxSwiftX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import RxSwift
import RxSwiftX

/// 待办事项 Store
class TodoStore: Store {

    enum Error: Swift.Error, CustomStringConvertible {
        case uncompletedWhenDelete
        case notFound

        var description: String {
            switch self {
            case .uncompletedWhenDelete:
                return "未完成事项不能删除"
            case .notFound:
                return "并没有该事项"
            }
        }

        var localizedDescription: String {
            return description
        }
    }

    fileprivate let todoList = Variable<[TodoItem]>([])

}

extension Getter where Base: TodoStore {

    var completedList: Observable<[TodoItem]> {
        return base.todoList.asObservable()
            .map { $0.filter { $0.isCompleted && !$0.isDeleted } }
    }

    var uncompletedList: Observable<[TodoItem]> {
        return base.todoList.asObservable()
            .map { $0.filter { !$0.isCompleted && !$0.isDeleted } }
    }

}

extension Mutation where Base: TodoStore {

    var completed: ([Int64]) -> Void {
        return { [unowned store = self.base] id in
            store.todoList.value = store.todoList.value.map { item in
                var item = item
                if id.contains(item.id) {
                    item.isCompleted = true
                }
                return item
            }
        }
    }

    var add: (_ name: String) -> Void {
        return { [unowned store = self.base] name in
            let id = (store.todoList.value.max()?.id ?? 0) + 1
            let todoItem = TodoItem(id: id, name: name)
            store.todoList.value.append(todoItem)
        }
    }

    var delete: ([Int64]) throws -> Void {
        return { [unowned store = self.base] id in
            store.todoList.value = try store.todoList.value.map { item in
                var item = item
                if id.contains(item.id) {
                    if !item.isCompleted {
                        throw TodoStore.Error.uncompletedWhenDelete
                    }
                    item.isDeleted = true
                }
                return item
            }
        }
    }

}

extension Action where Base: TodoStore {
    var delete: ([Int64]) -> Observable<String> {
        return { [unowned store = self.base as TodoStore] id -> Observable<String> in
            store.getters.completedList
                .flatMap { completedList -> Observable<String> in // TODO: 其实这里的逻辑时有问题的 ==
                    let items = completedList.filter { id.contains($0.id) }
                    if items.isEmpty {
                        return Observable.just("并没有这个代办事项") // TODO: TBD throws ?
                    } else {
                        return showEnsure("确定删除\(items.map { $0.name }.joined(separator: "、"))吗？")
                            .map { items.map { $0.id } }
                            .do(onNext: store.commit.delete)
                            .map { _ in "删除成功" }
                    }
            }
        }
    }
}
