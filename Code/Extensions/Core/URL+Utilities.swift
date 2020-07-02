//
//  URL+Utilities.swift
//  Demo
//
//  Created by Lea Marolt Sonnenschein on 02/07/2020.
//  Copyright © 2020 Unified Sense. All rights reserved.
//

import Foundation

#if canImport(os) 
import os
#endif

extension URL {
    
    /// Loads a URL as a String, if possible
    /// - Parameter encoding: The encoding strategy used to decode the URL with.
    /// - Returns: A String representation of the URL, or nil if none exists
    public func loadAsString(using encoding: String.Encoding = .utf8) -> String? {
        do {
            let data = try Data(contentsOf: self)
            return String(data: data, encoding: encoding)
        } catch(let error) {
            if #available(iOS 10.0, macOS 10.12, *) {
                os_log("Error parsing URL data. Description: %@", error.localizedDescription)
            } else {
                NSLog("Error parsing URL data. Description: %@", error.localizedDescription)
            }
            return nil
        }
    }
}
