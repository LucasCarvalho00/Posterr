//
//  PSUserProfileViewProtocol.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import UIKit

// MARK: - EnumState

public enum PSUserProfileViewState: Equatable {
    case hasData(PSUserProfileViewEntity)
    case isEmpty
}
// MARK: - ViewController

public protocol PSUserProfileViewViewControllerProtocol: AnyObject { }

// MARK: - View

public protocol PSUserProfileViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: PSUserProfileViewViewControllerProtocol? { get set }
    func setupUI(with viewState: PSUserProfileViewState)
}

// MARK: - Extension

extension PSUserProfileViewProtocol where Self: UIView {
    public var content: UIView { return self }
}
