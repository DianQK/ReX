//
//  Alert.swift
//  RxSwiftX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit
import RxSwift

func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
	   if let nav = base as? UINavigationController {
	       return topViewController(nav.visibleViewController)
	   }
	   if let tab = base as? UITabBarController {
	       if let selected = tab.selectedViewController {
	           return topViewController(selected)
	       }
	   }
	   if let presented = base?.presentedViewController {
	       return topViewController(presented)
	   }
	   return base
}

let showTextField: () -> Observable<String> = {
    return Observable.create { observer in
        let alert = UIAlertController(title: "添加新的待办事项", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in

        })
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
            observer.on(.completed)
        }))
        alert.addAction(UIAlertAction(title: "好", style: .default, handler: { _ in
            if let text = alert.textFields?.first?.text {
                observer.on(.next(text))
            }
            observer.on(.completed)
        }))
        topViewController()?.showDetailViewController(alert, sender: nil)
        return Disposables.create {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

let showEnsure: (_ title: String) -> Observable<Void> = { title in
    return Observable.create { observer in
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
            observer.on(.completed)
        }))
        alert.addAction(UIAlertAction(title: "好", style: .default, handler: { _ in
            observer.on(.next(()))
            observer.on(.completed)
        }))
        topViewController()?.showDetailViewController(alert, sender: nil)
        return Disposables.create {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
