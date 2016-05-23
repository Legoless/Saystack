//
//  UITableView+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

extension UITableView {
	public func scrollToLastCell(animated: Bool = false) {
		if numberOfSections > 0 {
			let numberOfRows = numberOfRowsInSection(numberOfSections - 1)
			if numberOfRows > 0 {
				scrollToRowAtIndexPath(NSIndexPath(forRow: numberOfRows - 1, inSection: numberOfSections - 1), atScrollPosition: .None, animated: animated)
			}
		}
	}
}