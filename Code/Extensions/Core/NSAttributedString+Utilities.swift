//
//  NSAttributedString+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 17/07/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

extension NSAttributedString {
    public func mutable () -> NSMutableAttributedString {
        return self.mutableCopy() as! NSMutableAttributedString
    }
}