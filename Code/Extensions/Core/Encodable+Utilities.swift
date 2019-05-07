//
//  Encodable+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 5/9/18.
//  Copyright © 2018 Unified Sense. All rights reserved.
//

import Foundation

public extension Encodable {
    func jsonString(with encoder: JSONEncoder) -> String? {
        do {
            let encodedObject = try encoder.encode(self)
            
            if let json = String(data: encodedObject, encoding: .utf8) {
                return json
            }
            
            return nil
        }
        catch {
            return nil
        }
    }
}

