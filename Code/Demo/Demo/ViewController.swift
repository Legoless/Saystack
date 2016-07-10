//
//  ViewController.swift
//  Demo
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

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
    }
}

