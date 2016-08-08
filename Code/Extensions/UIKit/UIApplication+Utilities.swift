//
//  UIApplication+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

public enum Environment {
    case Development
    case TestFlight
    case AppStore
}

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
    
    public class var environment : Environment {
        //
        // Check for Simulator
        //
        
        if UIDevice.currentDevice().simulator {
            return .Development
        }
        
        //
        // Check for development provisioning profile.
        //
        
        if let resource = NSBundle.mainBundle().pathForResource("embedded", ofType: "mobileprovision"), data = NSData(contentsOfFile: resource), profile = String(data: data, encoding: NSASCIIStringEncoding) {
            let cleared = profile.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).joinWithSeparator("")
            
            if cleared.containsString("<key>get-task-allow</key><true/>") {
                return .Development
            }
        }
        
        if NSBundle.mainBundle().appStoreReceiptURL?.lastPathComponent == "sandboxReceipt" {
            return .TestFlight
        }
        else {
            return .AppStore
        }
    }
}