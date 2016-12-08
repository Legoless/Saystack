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
        if let index = index(where: { $0 === object }) {
            self.remove(at: index)
        }
    }
}

extension Array where Element : Hashable {
    
    public func unique() -> Array {
        var seen: [Element : Bool] = [:]
        
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}

extension Array {
    public mutating func shuffle() {
        for i in 0 ..< (count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
    
    public func shuffled() -> Array {
        var shuffledArray = self
        shuffledArray.shuffle()
        
        return shuffledArray
    }
}

extension Array {
    public func containsType<T>(type: T.Type) -> Bool {
        for object in self {
            if object is T {
                return true
            }
        }
        
        return false
    }
    
    public func containsType<T>(type: T) -> Bool {
        return containsType(type: T.self)
    }
}
