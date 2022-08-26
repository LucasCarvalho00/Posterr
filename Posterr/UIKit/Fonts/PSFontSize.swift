//
//  PSFontSizes.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import UIKit

enum PSFontSize {
    case small
    case medium
    case large

    var size: CGFloat {
        switch self {
        case .small:
            return 8
        case .medium:
            return 14
        case .large:
            return 16
        }
    }
}
