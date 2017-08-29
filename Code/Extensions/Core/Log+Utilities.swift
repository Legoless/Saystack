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
    public func info (_ message: StaticString, _ args: CVarArg...) {
        os_log(message, log: self, type: .info, args)
    }
    public func debug (_ message: StaticString, _ args: CVarArg...) {
        os_log(message, log: self, type: .debug, args)
    }
    public func error (_ message: StaticString, _ args: CVarArg...) {
        os_log(message, log: self, type: .error, args)
    }
    public func fault (_ message: StaticString, _ args: CVarArg...) {
        os_log(message, log: self, type: .fault, args)
    }
}
