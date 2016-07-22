//
//  UIView+Position.swift
//  Saystack
//
//  Created by Dal Rupnik on 10/07/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

extension UIView {
    public func isAboveView(view: UIView?) -> Bool {
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
        
        let selfIndex = self.superview?.subviews.indexOf(self)
        let viewIndex = view.superview?.subviews.indexOf(view)
        
        return selfIndex > viewIndex
    }
    
    
    func isBelowView(view: UIView?) -> Bool {
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
        
        let selfIndex = self.superview?.subviews.indexOf(self)
        let viewIndex = view.superview?.subviews.indexOf(view)
        
        return selfIndex < viewIndex
    }
}
