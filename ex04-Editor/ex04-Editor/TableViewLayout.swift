//  TableViewLayout.swift
//  ex04-Viewer
//
//  Created by CHH51 on 12/19/18.

import UIKit
import Layout

internal protocol TableViewLayout {
    
}

extension TableViewLayout {
    internal func rowHeightFactor( view: UIView ) -> Double {
        switch view.traitCollection.preferredContentSizeCategory {
        case UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            return 2.8
        case UIContentSizeCategory.accessibilityExtraExtraLarge:
            return 2.6
        case UIContentSizeCategory.accessibilityExtraLarge:
            return 2.4
        case UIContentSizeCategory.accessibilityLarge:
            return 2.2
        case UIContentSizeCategory.accessibilityMedium:
            return 2.0
        case UIContentSizeCategory.extraExtraExtraLarge:
            return 1.8
        case UIContentSizeCategory.extraExtraLarge:
            return 1.6
        case UIContentSizeCategory.extraLarge:
            return 1.4
        default:
            return 1.0
        }
    }
}
