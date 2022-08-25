//
//  Extension+UIFont.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import UIKit

extension UIFont {
    public class var graphik: UIFont {
        return UIFont(name: "Graphik", size: PSFontSize.medium.size)!
    }
    
    public class var graphikSemibold: UIFont {
        return UIFont(name: "Graphik-Semibold", size: PSFontSize.medium.size)!
    }
    
    public class var graphikMedium: UIFont {
        return UIFont(name: "Graphik-Medium", size: PSFontSize.medium.size)!
    }
}
