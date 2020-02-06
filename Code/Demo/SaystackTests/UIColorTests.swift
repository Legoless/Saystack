//
//  UIColorTests.swift
//  SaystackTests
//
//  Created by Jure Lajlar on 06/02/2020.
//  Copyright © 2020 Unified Sense. All rights reserved.
//

import XCTest

class UIColorTests: XCTestCase {
    func testColorsWithHashPrefixAreEqual() {
        XCTAssertEqual(UIColor("#000000FF"), UIColor("000000FF"))
        XCTAssertEqual(UIColor("#000000"), UIColor("000000"))
        XCTAssertEqual(UIColor("#0000"), UIColor("0000"))
        XCTAssertEqual(UIColor("#000"), UIColor("000"))
    }
    
    func testInitializationWithInvalidInputThrows() {
        XCTAssertThrowsError(try UIColor(rgba_throws: ""))
        XCTAssertThrowsError(try UIColor(rgba_throws: "  "))
        XCTAssertThrowsError(try UIColor(rgba_throws: "bababz"))
        XCTAssertThrowsError(try UIColor(rgba_throws: "badinput"))
        XCTAssertThrowsError(try UIColor(rgba_throws: "#zzz"))
        XCTAssertThrowsError(try UIColor(rgba_throws: "#AA"))
    }
    
    func testFailedInitializationDefaultsToClearColor() {
        XCTAssertEqual(UIColor(""), .clear)
    }
    
    func testRedComponent() {
        var red = CGFloat(0)
        UIColor("#F00").getRed(&red, green: nil, blue: nil, alpha: nil)
        XCTAssertEqual(red, 1.0)
        
        UIColor("#FF00").getRed(&red, green: nil, blue: nil, alpha: nil)
        XCTAssertEqual(red, 1.0)
        
        UIColor("#FF0000").getRed(&red, green: nil, blue: nil, alpha: nil)
        XCTAssertEqual(red, 1.0)
    }
    
    func testGreenComponent() {
        var green = CGFloat(0)
        UIColor("#0F0").getRed(nil, green: &green, blue: nil, alpha: nil)
        XCTAssertEqual(green, 1.0)
        
        UIColor("#00FF00").getRed(nil, green: &green, blue: nil, alpha: nil)
        XCTAssertEqual(green, 1.0)
        
        UIColor("#00FF0000").getRed(nil, green: &green, blue: nil, alpha: nil)
        XCTAssertEqual(green, 1.0)
    }
    
    func testBlueComponent() {
        var blue = CGFloat(0)
        UIColor("#00F").getRed(nil, green: nil, blue: &blue, alpha: nil)
        XCTAssertEqual(blue, 1.0)
        
        UIColor("#0000FF").getRed(nil, green: nil, blue: &blue, alpha: nil)
        XCTAssertEqual(blue, 1.0)
        
        UIColor("#0000FF00").getRed(nil, green: nil, blue: &blue, alpha: nil)
        XCTAssertEqual(blue, 1.0)
    }
    
    func testAlphaComponent() {
        var alpha = CGFloat(0)
        UIColor("#00F").getRed(nil, green: nil, blue: nil, alpha: &alpha)
        XCTAssertEqual(alpha, 1.0)
        
        UIColor("#0000FF").getRed(nil, green: nil, blue: nil, alpha: &alpha)
        XCTAssertEqual(alpha, 1.0)
        
        UIColor("#0000FF00").getRed(nil, green: nil, blue: nil, alpha: &alpha)
        XCTAssertEqual(alpha, 0.0)
    }
}
