//
//  UIApplication+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

public enum Environment {
    case development
    case testFlight
    case appStore
}

extension UIApplication {
    public class func currentApplicationSupportDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    public class var appVersion : String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public class var name : String {
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    public class var build : String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    public class var bundleIdentifier : String {
        return Bundle.main.bundleIdentifier!
    }
    
    public class var environment : Environment {
        //
        // Check for Simulator
        //
        
        if UIDevice.current.isSimulator {
            return .development
        }
        
        //
        // Check for development provisioning profile.
        //
        
        if let resource = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") , (try? Data(contentsOf: URL(fileURLWithPath: resource))) != nil {
            return .development
        }
        
        if Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt" {
            return .testFlight
        }
        else {
            return .appStore
        }
    }
    
    /*
    @available(iOSApplicationExtension, unavailable)
    public func openSettings(options: [String : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        let url = URL(string: UIApplicationOpenSettingsURLString)!
        
        if #available(iOS 10.0, *) {
            open(url, options: options, completionHandler: completion)
        } else {
            openURL(url)
        }
    }*/
}
