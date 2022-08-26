//
//  PSHomeViewProtocol.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import UIKit

// MARK: - EnumState

public enum PSHomeViewState: Equatable {
    case hasData(PSHomeViewEntity)
    case hasError
    case loadScreen
    case messageSentSuccessfully
}
// MARK: - ViewController

public protocol PSHomeViewViewControllerProtocol: AnyObject {
    func didTapReload()
    func sendMessage(message: String)
}

// MARK: - View

public protocol PSHomeViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: PSHomeViewViewControllerProtocol? { get set }
    func setupUI(with viewState: PSHomeViewState)
}

// MARK: - Extension

extension PSHomeViewProtocol where Self: UIView {
    public var content: UIView { return self }
}

// MARK: - PSHomeDataView

public protocol PSHomeDataViewProtocol: AnyObject {
    func sendMessage(message: String)
}

// MARK: - PSHomeErrorView

public protocol PSHomeErrorViewDelegate: AnyObject {
    func didTapReload()
}
