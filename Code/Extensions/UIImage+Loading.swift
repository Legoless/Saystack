//
//  UIImage+Loading.swift
//  Saystack
//
//  Created by Dal Rupnik on 10/07/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

//
// MARK: - Extension provides utility methods to preload load image into memory.
//
// Note: When UIImage object is created from contents of file, the object has no image
//       data in memory and is actually loaded first time the image is drawn.
//       This is a good optimization, but might be a bottle neck, if many large images
//       are being drawn at the same time. This extension will immediatelly preload
//       image into memory, thus requiring no time for the image to load when displaying.
//
extension UIImage {
    public convenience init?(contentsOfFile path: String, immediate: Bool) {
        self.init(contentsOfFile: path)
        
        forceLoad()
    }
    
    class func preloadedImage(path: String) -> UIImage? {
        
        guard let image = UIImage(contentsOfFile: path), imageRef = image.CGImage else {
            return nil
        }
        
        let rect = CGRectMake(0.0, 0.0, CGFloat(CGImageGetWidth(imageRef)), CGFloat(CGImageGetHeight(imageRef)))
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedFirst.rawValue)
        
        guard let bitmapContext = CGBitmapContextCreate(nil, Int(rect.size.width), Int(rect.size.height), CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), CGImageGetColorSpace(imageRef), bitmapInfo.rawValue | CGBitmapInfo.ByteOrder32Little.rawValue) else {
            return nil
        }
        
        CGContextDrawImage(bitmapContext, rect, imageRef)
            
        let decompressedImageRef = CGBitmapContextCreateImage(bitmapContext)!
        let decompressedImage: UIImage = UIImage(CGImage: decompressedImageRef)

        return decompressedImage
    }
    
    func forceLoad() {
        guard let cgImage = CGImage else {
            return
        }
        
        let width = CGImageGetWidth(cgImage)
        let height = CGImageGetHeight(cgImage)
        
        if let colorspace: CGColorSpaceRef = CGImageGetColorSpace(cgImage) {
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.NoneSkipLast.rawValue)
            
            let context = CGBitmapContextCreate(nil, width, height, 8, width * 4, colorspace, bitmapInfo.rawValue)
            CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), cgImage)
        }
    }
}