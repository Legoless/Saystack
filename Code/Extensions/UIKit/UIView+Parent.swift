//
//  UIView+Parent.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

extension UIView {
    public func parentViewOfType<T>(_ type: T.Type) -> T? where T : UIView {
        var view = self.superview
        
        while (view != nil && !(view is T)) {
            view = view!.superview
        }
        
        if let view = view as? T {
            return view
        }
        
        return nil
    }
    
    public func parentTableViewCell () -> UITableViewCell? {
        return parentViewOfType(UITableViewCell.self)
    }
    
    public func parentCollectionViewCell () -> UICollectionViewCell? {
        return parentViewOfType(UICollectionViewCell.self)
    }
}
