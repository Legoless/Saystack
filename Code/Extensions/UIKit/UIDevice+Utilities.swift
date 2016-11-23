//
//  UIDevice+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 09/08/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

extension UIDevice {
    public var isSimulator : Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}
