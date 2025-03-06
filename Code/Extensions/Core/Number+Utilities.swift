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
// http://stackoverflow.com/questions/24007129/how-does-one-generate-a-random-number-in-apples-swift-language
//

private func arc4random <T: FixedWidthInteger> (type: T.Type) -> T {
    var r = T.zero
    withUnsafeMutableBytes(of: &r) { buffer in
        arc4random_buf(buffer.baseAddress, buffer.count)
    }
    return r
}

public extension UInt64 {
    static func random(from: UInt64 = min, to: UInt64 = max) -> UInt64 {
        var m: UInt64
        let u = to - from
        var r = arc4random(type: UInt64.self)
        
        if u > UInt64(Int64.max) {
            m = 1 + ~u
        } else {
            m = ((max - (u * 2)) + 1) % u
        }
        
        while r < m {
            r = arc4random(type: UInt64.self)
        }
        
        return (r % u) + from
    }
}

public extension Int64 {
    static func random(from: Int64 = min, to: Int64 = max) -> Int64 {
        //let (s, overflow) = Int64.subtractWithOverflow(to, from)
        let (s, overflow) = to.subtractingReportingOverflow(from)
        let u = overflow ? UInt64.max - UInt64(~s) : UInt64(s)
        let r = UInt64.random(to: u)
        
        if r > UInt64(Int64.max)  {
            return Int64(r - (UInt64(~from) + 1))
        } else {
            return Int64(r) + from
        }
    }
}

public extension UInt32 {
    static func random(from: UInt32 = min, to: UInt32 = max) -> UInt32 {
        return arc4random_uniform(to - from) + from
    }
}

public extension Int32 {
    static func random(from: Int32 = min, to: Int32 = max) -> Int32 {
        let r = arc4random_uniform(UInt32(Int64(to) - Int64(from)))
        return Int32(Int64(r) + Int64(from))
    }
}

public extension UInt {
    static func random(from: UInt = min, to: UInt = max) -> UInt {
        return UInt(UInt64.random(from: UInt64(from), to: UInt64(to)))
    }
}

public extension Int {
    static func random(from: Int = min, to: Int = max) -> Int {
        return Int(Int64.random(from: Int64(from), to: Int64(to)))
    }
}

public extension Float {
    static func random() -> Float {
        return Float(UInt64.random()) / Float(UInt64.max)
    }
}

public extension Double {
    static func random() -> Double {
        return Double(UInt64.random()) / Double(UInt64.max)
    }
}
