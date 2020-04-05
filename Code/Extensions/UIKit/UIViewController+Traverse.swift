//
//  UIViewController+Traverse.swift
//  Saystack
//
//  Created by Dal Rupnik on 4/5/20.
//  Copyright © 2020 Unified Sense. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    func findController<T : UIViewController>(ofType: T.Type) -> T? {
        let controller = self
        
        if controller.isKind(of: T.self) {
            return controller as? T
        }
        
        if let navigationController = controller as? UINavigationController {
            for childController in navigationController.viewControllers {
                if let child = childController.findController(ofType: T.self) {
                    return child
                }
            }
        }
        
        if let splitController = controller as? UISplitViewController {
            for childController in splitController.viewControllers {
                if let child = childController.findController(ofType: T.self) {
                    return child
                }
            }
        }
        
        if let tabBarController = controller as? UITabBarController {
            for childController in tabBarController.viewControllers ?? [] {
                if let child = childController.findController(ofType: T.self) {
                    return child
                }
            }
        }
        
        return nil
    }
}
