//
//  Extension+UIView.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import UIKit

extension UIView {
    
    public var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }

        return self.topAnchor
    }
    
    public var safeLeadingAnchor: NSLayoutXAxisAnchor {
      if #available(iOS 11.0, *) {
        return self.safeAreaLayoutGuide.leadingAnchor
      }

        return self.leftAnchor
    }
     
    public var safeTrailingAnchor: NSLayoutXAxisAnchor {
      if #available(iOS 11.0, *) {
        return self.safeAreaLayoutGuide.trailingAnchor
      }

        return self.rightAnchor
    }
    
    public var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }

        return self.bottomAnchor
    }

    
    /// Constraints to its superview
    ///
    /// - Parameters:
    ///   - top: Top constant. Default value is 0.
    ///   - leading: Leading constant. Default value is 0.
    ///   - trailing: Trailing constant. Default value is 0.
    ///   - bottom: Bottom constant. Default value is 0.
    public func constraintToSuperview(top: CGFloat = 0,
                                     leading: CGFloat = 0,
                                     trailing: CGFloat = 0,
                                     bottom: CGFloat = 0,
                                     bottomPriority: UILayoutPriority = .required) {
       
       guard let superview = self.superview else {
           return
       }
       let bottomConstraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom)

       let constraints = [
           topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
           trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing),
           leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading),
           bottomConstraint
       ]

       bottomConstraint.priority = bottomPriority
       NSLayoutConstraint.activate(constraints)
    }

    /// Constraints to its safeArea
    ///
    /// - Parameters:
    ///   - top: Top constant. Default value is 0.
    ///   - leading: Leading constant. Default value is 0.
    ///   - trailing: Trailing constant. Default value is 0.
    ///   - bottom: Bottom constant. Default value is 0.
    public func constraintToSafeArea(top: CGFloat = 0,
                                     leading: CGFloat = 0,
                                     trailing: CGFloat = 0,
                                     bottom: CGFloat = 0,
                                     bottomPriority: UILayoutPriority = .required) {
       guard let superview = self.superview else {
           return
       }
       let bottomConstraint = bottomAnchor.constraint(equalTo: superview.safeBottomAnchor, constant: bottom)

       let constraints = [
            topAnchor.constraint(equalTo: superview.safeTopAnchor, constant: top),
            trailingAnchor.constraint(equalTo: superview.safeTrailingAnchor, constant: trailing),
            leadingAnchor.constraint(equalTo: superview.safeLeadingAnchor, constant: leading),
           bottomConstraint
       ]

       bottomConstraint.priority = bottomPriority
       NSLayoutConstraint.activate(constraints)
    }
}
