//
//  PSFontStyle.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import UIKit

public struct PSFontStyle {
    
    /// Font Graphik Semi Bold with size 13.0
    static let title = UIFont.graphikSemibold.withSize(PSFontSize.large.size)
    
    /// Font Graphik with size 14.0
    static let description = UIFont.graphik.withSize(PSFontSize.medium.size)
    
    /// Font Graphik with size 8.0
    static let smallComponent = UIFont.graphik.withSize(PSFontSize.small.size)
    
    /// Font Graphik with size 14.0
    static let component = UIFont.graphik.withSize(PSFontSize.medium.size)
}
