//
//  UIView+Parent.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

extension UIView {
    func parentViewOfType<T where T : UIView>(type: T.Type) -> T? {
        var view = self.superview
        
        while (view != nil && !(view is T)) {
            view = view!.superview
        }
        
        if let view = view as? T {
            return view
        }
        
        return nil
    }
    
    func parentTableViewCell () -> UITableViewCell? {
        return parentViewOfType(UITableViewCell.self)
    }
    
    func parentCollectionViewCell () -> UICollectionViewCell? {
        return parentViewOfType(UICollectionViewCell.self)
    }
    
}