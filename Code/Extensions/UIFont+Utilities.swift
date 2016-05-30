//
//  UIFont+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 30/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

public enum FontWeight : String {
    case Black              = "Black"
    case BlackItalic        = "BlackItalic"
    case Bold               = "Bold"
    case BoldItalic         = "BoldItalic"
    case Book               = "Book"
    case BookItalic         = "BookItalic"
    case ExtraBlack         = "ExtraBlack"
    case ExtraBlackItalic   = "ExtraBlackItalic"
    case Heavy              = "Heavy"
    case HeavyItalic        = "HeavyItalic"
    case Italic             = "Italic"
    case Light              = "Light"
    case LightItalic        = "LightItalic"
    case Medium             = "Medium"
    case MediumItalic       = "MediumItalic"
    case Regular            = "Regular"
    case Thin               = "Thin"
    case ThinItalic         = "ThinItalic"
    case UltraLight         = "UltraLight"
    case UltraLightItalic   = "UltraLightItalic"
}

extension UIFont {
    public convenience init?(name fontName: String, size fontSize: CGFloat, weight fontWeight: FontWeight) {
        self.init(name: fontName + "-" + fontWeight.rawValue, size: fontSize)
    }
}
