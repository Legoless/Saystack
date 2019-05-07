//
//  UIStoryboard+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 04/07/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    class func initialViewControllerInStoryboard(name: String, bundle: Bundle? = nil) -> UIViewController? {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateInitialViewController()
    }
}
