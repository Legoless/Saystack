//
//  ViewController.swift
//  Demo
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import os.log
import Saystack
import UIKit

@available(iOS 10.0, *)
let log = OSLog(subsystem: "com.unifiedsense.saystack.testing", category: "Testing")

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Double.random())
        print(Double.random())
        print(Double.random())
        
        print(Float.random())
        print(Float.random())
        print(Float.random())
        
        var array = [ 1, 2, 3, 4, 5, 6 ]
        
        let shuffled = array.shuffled()
        
        print (shuffled)
        
        print (array)
        
        array.shuffle()
        
        print(array)
        
        let emails = [
            "email@domain.com",
            "firstname.lastname@domain.com",
            "email@subdomain.domain.com",
            "firstname+lastname@domain.com",
            "email@123.123.123.123",
            "email@[123.123.123.123]",
            "“email”@domain.com",
            "1234567890@domain.com",
            "email@domain-one.com",
            "_______@domain.com",
            "email@domain.name",
            "email@domain.co.jp",
            "firstname-lastname@domain.com",
            "email@domain.web",
            
            "plainaddress",
            "#@%^%#$@#$@#.com",
            "@domain.com",
            "email.domain.com",
            "email@domain@domain.com",
            ".email@domain.com",
            "email.@domain.com",
            "email@.domain.com",
            "email..email@domain.com",
            "あいうえお@domain.com",
            "email@domain.com",
            "email@domain",
            "email@-domain.com",
            "email@111.222.333.44444",
            "email@domain..com",
            "test@test",
            "test@test.c",
            "test@test.cc",
            "test@test.com",
            "@t.com",
            "tets@tea."
        ]
        
        for email in emails {
            print("\(email) is " + (email.isValidEmail ? "valid" : "invalid"))
        }
        
        print("I am running in \(UIApplication.environment) environment")
        
        let elements = [ "one", "two", "three", "two", "three", "four" ]
        
        print ("Unique elements: \(elements.unique())")
        
        if let viewControllers = navigationController?.viewControllers {
            let containsController = viewControllers.containsType(type: ViewController.self)
            let containsAnotherClass = viewControllers.containsType(type: self)
            let containsMissingClass = viewControllers.containsType(type: AppDelegate.self)
            
            print ("It contains view controller: \(view) contains: \(containsController) contains another: \(containsAnotherClass)")
            print ("Does not contain: \(containsMissingClass)")
        }
        
        print ("Model identifier: \(UIDevice.current.modelIdentifier) - model: \(UIDevice.current.readableModel)")
        print ("Device identifier: \(UIDevice.current.deviceIdentifier)")
        
        print ("Running on thread: \(Thread.current.threadId)")
        
        let queue = DispatchQueue(label: "com.unifiedsense.Saystack.background")
        
        queue.async {
            print ("This is now running on thread: \(Thread.current.threadId)")
        }
        
        //
        // Colors
        //
        
        let argb1 = "#ABCD"
        let argb2 = "#AABBCCDD"
        
        print("First color: \(argb1.argb2rgba()!)")
        print("Second color: \(argb2.argb2rgba()!)")
        
        let thirdColor = try! UIColor(rgba_throws: "#AAB")
        print("Third color: \(thirdColor)")
        
        //
        // Logging
        //
        
        let stringValue = "Acompany"
        let intValue = 257
        let doubleValue = 255.7
        let booleanValue = false
        let arrayMixed: [Any] = ["String", 257, 255.7, true]
        let dictionary: [String:Any] = ["Key 1":"Acompany", "Key2": 257, "Key3": 255.7, "Key4": true]
        let date = Date()
        
        
        if #available(iOS 10.0, *) {
            os_log("\nString value: %@,\n Int value %lu,\n Double: %.2f\nArray: %@,\n Boolean value: %@,\n Dictonary value: %@,\n Array count: %lu", log: log, type: .info, stringValue, intValue, doubleValue, array, booleanValue as CVarArg, dictionary, arrayMixed.count)
            
            os_log("Forced: %@, last ping %{time_t}d", log: log, type: .info, booleanValue as CVarArg, date as CVarArg)
            
            print("----------------")
            
            log.info("\nString value: %@,\n Int value %lu,\n Double: %.2f\nArray: %@,\n Boolean value: %@,\n Dictonary value: %@,\n Array count: %lu", stringValue, intValue, doubleValue, array, booleanValue as CVarArg, dictionary, arrayMixed.count)
        } else {
            // Fallback on earlier versions
        }

    }
}

