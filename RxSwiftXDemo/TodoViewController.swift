//
//  TodoViewController.swift
//  RxSwiftX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

typealias TodoSectionModel = AnimatableSectionModel<String, TodoItem>

class TodoViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addTodoItemBarButtonItem: UIBarButtonItem!

    private let store = TodoStore()

    fileprivate let dataSource = RxTableViewSectionedAnimatedDataSource<TodoSectionModel>()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.configureCell = { dataSource, tableView, indexPath, element in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = element.name
            return cell
        }

        dataSource.canEditRowAtIndexPath = { _ in true }

        dataSource.titleForHeaderInSection = { dataSource, section in
            return dataSource.sectionModels[section].model
        }

        let uncompletedSection = store.getters.uncompletedList
            .map { TodoSectionModel(model: "未完成", items: $0) }

        let completedSection = store.getters.completedList
            .map { TodoSectionModel(model: "已完成", items: $0) }

        Observable.combineLatest([uncompletedSection, completedSection]) { $0 }
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)

        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)

        let item = tableView.rx.itemDeleted
            .map { [unowned self] in self.dataSource[$0] }

        // 删除一个待办事项
        item.filter { $0.isCompleted }.map { [$0.id] }
            .flatMap(store.dispatch.delete)
            .subscribe(onNext: { [unowned self] message in
                HUD.showMessage(message, on: self.view)
            })
            .addDisposableTo(disposeBag)

        // 完成一个待办事项
        item.filter { !$0.isCompleted }.map { [$0.id] }
            .subscribe(onNext: store.commit.completed)
            .addDisposableTo(disposeBag)

        // 添加一个待办事项
        addTodoItemBarButtonItem.rx.tap
            .flatMap(showTextField)
            .subscribe(onNext: store.commit.add)
            .addDisposableTo(disposeBag)

    }

}

extension TodoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        if dataSource[indexPath].isCompleted {
            return "删除"
        } else {
            return "完成"
        }
    }

}
