//
//  ViewController.swift
//  Demo
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Saystack
import UIKit

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
        
        print ("Device identifier: \(UIDevice.current.modelIdentifier) - model: \(UIDevice.current.readableModel)")
    }
}

