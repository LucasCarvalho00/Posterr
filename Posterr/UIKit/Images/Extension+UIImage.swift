//
//  Extension+UIImage.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import UIKit

fileprivate class UIImageExtensions { }

extension UIImage {
    
    public class var magnifyingGlassIcon: UIImage {
        return UIImage(named: "ic_magnifyingGlassIcon", in: Bundle(for: UIImageExtensions.self), compatibleWith: nil)!
    }
    
    public class var imageNotFount: UIImage {
        return UIImage(named: "image_notFound", in: Bundle(for: UIImageExtensions.self), compatibleWith: nil)!
    }
    
    public class var imageAlert: UIImage {
        return UIImage(named: "image_alert", in: Bundle(for: UIImageExtensions.self), compatibleWith: nil)!
    }
    
    public class var chevronRight: UIImage {
        return UIImage(named: "ic_chevron_right", in: Bundle(for: UIImageExtensions.self), compatibleWith: nil)!
    }
}
