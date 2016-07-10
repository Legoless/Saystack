//
//  Array+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

extension Array where Element : AnyObject {
    public mutating func remove(object: Element) {
        if let index = indexOf({ $0 === object }) {
            removeAtIndex(index)
        }
    }
    
    public mutating func shuffle() {
        for i in 0 ..< (count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
}