//
//  Number+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 30/06/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

//
// Parts of code taken from post at:
//  http://stackoverflow.com/questions/24007129/how-does-one-generate-a-random-number-in-apples-swift-language
//

private func arc4random <T: IntegerLiteralConvertible> (type: T.Type) -> T {
    var r: T = 0
    arc4random_buf(&r, sizeof(T))
    return r
}

public extension UInt64 {
    public static func random(lower: UInt64 = min, upper: UInt64 = max) -> UInt64 {
        var m: UInt64
        let u = upper - lower
        var r = arc4random(UInt64)
        
        if u > UInt64(Int64.max) {
            m = 1 + ~u
        } else {
            m = ((max - (u * 2)) + 1) % u
        }
        
        while r < m {
            r = arc4random(UInt64)
        }
        
        return (r % u) + lower
    }
}

public extension Int64 {
    public static func random(lower: Int64 = min, upper: Int64 = max) -> Int64 {
        let (s, overflow) = Int64.subtractWithOverflow(upper, lower)
        let u = overflow ? UInt64.max - UInt64(~s) : UInt64(s)
        let r = UInt64.random(upper: u)
        
        if r > UInt64(Int64.max)  {
            return Int64(r - (UInt64(~lower) + 1))
        } else {
            return Int64(r) + lower
        }
    }
}

public extension UInt32 {
    static func random(lower: UInt32 = min, upper: UInt32 = max) -> UInt32 {
        return arc4random_uniform(upper - lower) + lower
    }
}

public extension Int32 {
    static func random(lower: Int32 = min, upper: Int32 = max) -> Int32 {
        let r = arc4random_uniform(UInt32(Int64(upper) - Int64(lower)))
        return Int32(Int64(r) + Int64(lower))
    }
}

public extension UInt {
    public static func random(lower: UInt = min, upper: UInt = max) -> UInt {
        switch (__WORDSIZE) {
        case 32: return UInt(UInt32.random(UInt32(lower), upper: UInt32(upper)))
        case 64: return UInt(UInt64.random(UInt64(lower), upper: UInt64(upper)))
        default: return lower
        }
    }
}

public extension Int {
    public static func random(lower: Int = min, upper: Int = max) -> Int {
        switch (__WORDSIZE) {
        case 32: return Int(Int32.random(Int32(lower), upper: Int32(upper)))
        case 64: return Int(Int64.random(Int64(lower), upper: Int64(upper)))
        default: return lower
        }
    }
}

public extension Float {
    public static func random() -> Float {
        return Float(UInt64.random()) / Float(UInt64.max)
    }
}

public extension Double {
    public static func random() -> Double {
        return Double(UInt64.random()) / Double(UInt64.max)
    }
}