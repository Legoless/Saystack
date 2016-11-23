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
        
        guard let image = UIImage(contentsOfFile: path), let imageRef = image.cgImage else {
            return nil
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(imageRef.width), height: CGFloat(imageRef.height))
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        guard let bitmapContext = CGContext(data: nil, width: Int(rect.size.width), height: Int(rect.size.height), bitsPerComponent: imageRef.bitsPerComponent, bytesPerRow: imageRef.bytesPerRow, space: imageRef.colorSpace!, bitmapInfo: bitmapInfo.rawValue | CGBitmapInfo.byteOrder32Little.rawValue) else {
            return nil
        }
        
        bitmapContext.draw(imageRef, in: rect)
            
        let decompressedImageRef = bitmapContext.makeImage()!
        let decompressedImage: UIImage = UIImage(cgImage: decompressedImageRef)

        return decompressedImage
    }
    
    func forceLoad() {
        guard let cgImage = cgImage else {
            return
        }
        
        let width = cgImage.width
        let height = cgImage.height
        
        if let colorspace: CGColorSpace = cgImage.colorSpace {
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue)
            
            let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorspace, bitmapInfo: bitmapInfo.rawValue)
            context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        }
    }
}
