//
//  PSHomeProtocol.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import UIKit

// MARK: - ViewController

public protocol PSHomeViewControllerProtocol: AnyObject {
    var viewProtocol: PSHomeViewProtocol? { get }
    var viewModelProtocol: PSHomeViewModelProtocol? { get }
    var flowProtocol: PSHomeViewFlowProtocol? { get set }
    func setupUI(with viewState: PSHomeViewState)
}

// MARK: - ViewModel

public protocol PSHomeViewModelProtocol: AnyObject {
    var viewController: PSHomeViewControllerProtocol? { get set }
    func initState()
    func sendMessage(entity: PSHomeViewNewMessageEntity)
}

// MARK: - FlowController

public protocol PSHomeViewFlowProtocol: AnyObject {
    func presentPSUserProfile()
}
