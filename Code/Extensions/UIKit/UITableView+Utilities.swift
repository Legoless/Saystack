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
			let numberOfRows = self.numberOfRows(inSection: numberOfSections - 1)
			if numberOfRows > 0 {
				scrollToRow(at: IndexPath(row: numberOfRows - 1, section: numberOfSections - 1), at: .none, animated: animated)
			}
		}
	}
}
