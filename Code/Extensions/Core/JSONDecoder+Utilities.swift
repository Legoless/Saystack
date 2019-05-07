//
//  JSONDecoder+Utilities.swift
//  Demo
//
//  Created by Dal Rupnik on 5/7/19.
//  Copyright © 2019 Unified Sense. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, from url: URL) throws -> T where T : Decodable {
        let data = try Data(contentsOf: url)
        
        return try self.decode(type, from: data)
    }
}
