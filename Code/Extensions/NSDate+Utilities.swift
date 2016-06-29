//
//  NSDate+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 29/06/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

public extension NSDate {
    public func numberOfMonths(date: NSDate) -> Int {
        let fromComponents = NSCalendar.currentCalendar().components([.Month, .Year], fromDate: self)
        let toComponents = NSCalendar.currentCalendar().components([.Month, .Year], fromDate: date)
        
        return ((toComponents.year - fromComponents.year) * 12) + (toComponents.month - fromComponents.month)
    }
}