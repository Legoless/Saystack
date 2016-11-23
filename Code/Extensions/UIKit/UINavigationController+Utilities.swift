//
//  UINavigationController+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 17/10/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

extension UINavigationController {
    public func pushViewControllerStack(viewControllers: [UIViewController], animated: Bool) {
        var currentViewControllers = self.viewControllers
        currentViewControllers.append(contentsOf: viewControllers)
        
        setViewControllers(currentViewControllers, animated: animated)
    }
}
