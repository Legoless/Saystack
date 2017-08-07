//
//  UIDevice+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 09/08/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import ObjectiveC
import UIKit

extension UIDevice {
    public var isSimulator : Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    public var modelIdentifier : String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    public var readableModel : String {
        
        let identifier = modelIdentifier
        
        switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
            case "AppleTV5,3":                              return "Apple TV"
            case "i386", "x86_64":                          return "Simulator"
            
            default:                                        return identifier
        }
    }
    
    //
    // MARK: Device identification
    //
    
    private static let DeviceIdentifierKey = "Saystack.DeviceIdentifierKey"
    
    /*!
     *  Returns unique devide identifier
     */
    public var deviceIdentifier : UUID {
        if let advertisingIdentifier = advertisingIdentifier {
            return advertisingIdentifier
        }
        
        let userDefaults = UserDefaults.standard
        
        if let id = userDefaults.string(forKey: UIDevice.DeviceIdentifierKey), let uuid = UUID(uuidString: id) {
            return uuid
        }
        
        if let id = UIDevice.current.identifierForVendor {
            userDefaults.set(id.uuidString, forKey: UIDevice.DeviceIdentifierKey)
            
            return id
        }
        
        let id = UUID()
        
        userDefaults.set(id, forKey: UIDevice.DeviceIdentifierKey)
        
        return id
    }
    
    /*!
     *  Returns advertising identifier if AdSupport.framework is linked.
     *
     *  @note It uses Objective-C Runtime inspection to detect,
     *  so no direct dependency to iAd is created in Swift.
     */
    private var advertisingIdentifier : UUID? {
        guard let managerClass = NSClassFromString("ASIdentifierManager") as? NSObjectProtocol else {
            return nil
        }
        
        //
        // To ensure the dynamic code works correctly and it is future proof, we check for each call that can crash it.
        //
        
        let sharedSelector = NSSelectorFromString("sharedManager")
        
        if !managerClass.responds(to: sharedSelector) {
            return nil
        }
        
        guard let shared = managerClass.perform(sharedSelector) as? NSObjectProtocol else {
            return nil
        }
        
        guard let managerPointer = shared as? Swift.Unmanaged<AnyObject> else {
            return nil
        }
        
        guard let manager = managerPointer.takeUnretainedValue() as? NSObject else {
            return nil
        }
        
        //
        // Check if advertising is enabled to respect Apple's policy
        //
        
        let enabledSelector = NSSelectorFromString("isAdvertisingTrackingEnabled")
        
        if !manager.responds(to: enabledSelector) {
            return nil
        }
        
        guard let _ = manager.perform(enabledSelector) else {
            return nil
        }
        
        //
        // Return advertising selector
        //
        
        let advertisingSelector = NSSelectorFromString("advertisingIdentifier")
        
        if !manager.responds(to: advertisingSelector) {
            return nil
        }
        
        guard let identifier = manager.perform(advertisingSelector) else {
            return nil
        }
        
        return identifier.takeUnretainedValue() as? UUID
    }
}
