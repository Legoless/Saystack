//
//  Log+Utilities.swift
//  Demo
//
//  Created by Dal Rupnik on 29/08/2017.
//  Copyright © 2017 Unified Sense. All rights reserved.
//

import os.log

@available(iOS 10.0, OSX 10.12, *)
public extension OSLog {
    func info (_ message: StaticString, _ args: Any...) {
        let varArgs = args.map { $0 as! CVarArg }
        print("\(varArgs)")
        
        
        os_log(message, log: self, type: .info, varArgs)
    }
    func debug (_ message: StaticString, _ args: Any...) {
        let varArgs = args.map { $0 as! CVarArg }
        
        os_log(message, log: self, type: .debug, varArgs)
    }
    func error (_ message: StaticString, _ args: Any...) {
        let varArgs = args.map { $0 as! CVarArg }
        
        os_log(message, log: self, type: .error, varArgs)
    }
    func fault (_ message: StaticString, _ args: Any...) {
        let varArgs = args.map { $0 as! CVarArg }
        
        os_log(message, log: self, type: .fault, varArgs)
    }
}
