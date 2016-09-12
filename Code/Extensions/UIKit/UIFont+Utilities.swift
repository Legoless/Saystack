//
//  UIFont+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 30/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

public enum FontWeight : String {
    case black              = "Black"
    case blackItalic        = "BlackItalic"
    case bold               = "Bold"
    case boldItalic         = "BoldItalic"
    case book               = "Book"
    case bookItalic         = "BookItalic"
    case extraBlack         = "ExtraBlack"
    case extraBlackItalic   = "ExtraBlackItalic"
    case heavy              = "Heavy"
    case heavyItalic        = "HeavyItalic"
    case italic             = "Italic"
    case light              = "Light"
    case lightItalic        = "LightItalic"
    case medium             = "Medium"
    case mediumItalic       = "MediumItalic"
    case regular            = "Regular"
    case thin               = "Thin"
    case thinItalic         = "ThinItalic"
    case ultraLight         = "UltraLight"
    case ultraLightItalic   = "UltraLightItalic"
}

extension UIFont {
    public convenience init?(name fontName: String, size fontSize: CGFloat, weight fontWeight: FontWeight) {
        self.init(name: fontName + "-" + fontWeight.rawValue, size: fontSize)
    }
}
