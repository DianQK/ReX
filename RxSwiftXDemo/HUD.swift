//
//  HUD.swift
//  RxSwiftX
//
//  Created by DianQK on 08/12/2016.
//  Copyright © 2016 T. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {

    static func showMessage(_ message: String, on view: UIView? = UIApplication.shared.keyWindow) {
        guard let view = view else {
            return
        }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)

        hud.mode = MBProgressHUDMode.text
        hud.label.text = message
        hud.label.numberOfLines = 0
        hud.margin = 10
        hud.offset.y = -50
        hud.removeFromSuperViewOnHide = true
        hud.isUserInteractionEnabled = false

        hud.hide(animated: true, afterDelay: 1)
    }
}

public struct HUD {

    private init() { }

    public static func showMessage(_ message: String, on view: UIView? = UIApplication.shared.keyWindow) {
        MBProgressHUD.showMessage(message, on: view)
    }
}
