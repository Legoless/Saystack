//
//  NSThread+Display.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

extension Thread {
    public var threadId : String {
        get {
            var display = self.debugDescription
            let numberRange = display.range(of: "number = ")?.upperBound ?? display.startIndex
            
            display = String(display[numberRange...])
            display = String(display[..<(display.range(of: ",")?.lowerBound ?? display.endIndex)])
            
            return display
        }
    }
}
