//
//  UIColor+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 10/07/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
