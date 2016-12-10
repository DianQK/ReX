//
//  AppDelegate.swift
//  RxSwiftXDemo
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let countStore = CountStore()

        countStore.plugin
            .use(state: { state in
                _ = state.count.asObservable()
                    .subscribe(onNext: { count in
                        print("Plugin: \(count)")
                    })
            }, getter: { getter in

            }, mutation: { mutation in

            }, action: { action in

            })

        print(countStore.state.count.value)
        countStore.commit.increment()
        print(countStore.state.count.value)

        return true
    }

}
