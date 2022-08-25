//
//  PSUserProfileProtocol.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import UIKit

// MARK: - ViewController

public protocol PSUserProfileViewControllerProtocol: AnyObject {
    var viewProtocol: PSUserProfileViewProtocol? { get }
    var viewModelProtocol: PSUserProfileViewModelProtocol? { get }
    var flowProtocol: PSUserProfileViewFlowProtocol? { get set }
    func setupUI(with viewState: PSUserProfileViewState)
}

// MARK: - ViewModel

public protocol PSUserProfileViewModelProtocol: AnyObject {
    var viewController: PSUserProfileViewControllerProtocol? { get set }
    func initState()
}

// MARK: - FlowController

public protocol PSUserProfileViewFlowProtocol: AnyObject { }
