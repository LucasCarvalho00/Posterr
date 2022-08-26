//
//  Extension+NSObject.swift
//  Posterr
//
//  Created by Lucas Carvalho on 26/08/22.
//

import Foundation

extension NSObject {
    static var className: String {
        return NSStringFromClass(self)
            .components(separatedBy: ".")
            .last ?? NSStringFromClass(self)
    }
}
