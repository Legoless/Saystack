//
//  NSDate+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 29/06/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

public extension Date {
    public func numberOfMonths(date: Date) -> Int {
        let fromComponents = Calendar.current.dateComponents([.month, .year], from: self)
        let toComponents = Calendar.current.dateComponents([.month, .year], from: date)
        
        return ((toComponents.year! - fromComponents.year!) * 12) + (toComponents.month! - fromComponents.month!)
    }
}
