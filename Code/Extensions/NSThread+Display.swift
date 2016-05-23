//
//  NSThread+Display.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

extension NSThread {
    public var threadId : String {
        get {
            var display = self.debugDescription
            display = display.substringFromIndex(display.rangeOfString("number = ")!.endIndex)
            display = display.substringToIndex(display.rangeOfString(",")!.startIndex)
            
            return display
        }
    }
}