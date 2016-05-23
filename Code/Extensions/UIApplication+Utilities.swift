//
//  UIApplication+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

extension UIApplication {
    class func currentApplicationSupportDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}