//
//  UIApplication+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

extension UIApplication {
    public class func currentApplicationSupportDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    public class var appVersion : String {
        return NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public class var name : String {
        return NSBundle.mainBundle().infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    public class var build : String {
        return NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
    }
    
    public class var bundleIdentifier : String {
        return NSBundle.mainBundle().bundleIdentifier!
    }
}