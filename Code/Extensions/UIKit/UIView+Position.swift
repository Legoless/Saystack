//
//  UIView+Position.swift
//  Saystack
//
//  Created by Dal Rupnik on 10/07/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


extension UIView {
    public func isAboveView(_ view: UIView?) -> Bool {
        guard let view = view else {
            return false
        }
        
        if self.superview == nil || view.superview == nil || view == self {
            return false
        }
        
        //
        // Different superviews
        //
        if view.superview != self.superview {
            return false
        }
        
        let selfIndex = self.superview?.subviews.index(of: self)
        let viewIndex = view.superview?.subviews.index(of: view)
        
        return selfIndex > viewIndex
    }
    
    
    func isBelowView(_ view: UIView?) -> Bool {
        guard let view = view else {
            return false
        }
        
        if self.superview == nil || view.superview == nil || view == self {
            return false
        }
        
        //
        // Different superviews
        //
        if view.superview != self.superview {
            return false
        }
        
        let selfIndex = self.superview?.subviews.index(of: self)
        let viewIndex = view.superview?.subviews.index(of: view)
        
        return selfIndex < viewIndex
    }
}
