//
//  UIImage+Creation.swift
//  Saystack
//
//  Created by Dal Rupnik on 17/12/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

public extension UIImage {
    public class func create(with color: UIColor, of size: CGSize = CGSize(width: 1.0, height: 1.0)) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y:0), size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
