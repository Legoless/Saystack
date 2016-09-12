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
            display = display.substring(from: display.range(of: "number = ")!.upperBound)
            display = display.substring(to: display.range(of: ",")!.lowerBound)
            
            return display
        }
    }
}
