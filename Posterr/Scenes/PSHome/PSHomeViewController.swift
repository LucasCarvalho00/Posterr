//
//  PSHomeViewController.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import Foundation
import UIKit

public final class PSHomeViewController: UIViewController {

    // MARK: - Constants

    private struct Constants {
        static let title: String = NSLocalizedString("Home screen", comment: "")
    }
    
    // MARK: - Public Attributes

    public let viewProtocol: PSHomeViewProtocol?
    public let viewModelProtocol: PSHomeViewModelProtocol?
    public var flowProtocol: PSHomeViewFlowProtocol?

    // MARK: - Initializer

    public init(
        viewProtocol: PSHomeViewProtocol,
        viewModelProtocol: PSHomeViewModelProtocol
    ) {
        self.viewProtocol = viewProtocol
        self.viewModelProtocol = viewModelProtocol
        super.init(nibName: nil, bundle: nil)
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    public override func loadView() {
        contentSetup()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModelProtocol?.initState()
        self.title = Constants.title
    }

    // MARK: - Private Functions

    private func setup() {
        let rightBarButtonItem = UIBarButtonItem.init(image: .icAccount.withTintColor(.white), style: .done, target: self, action: #selector(didTapOpenUserSettings))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    private func contentSetup() {
        if let contentView = viewProtocol {
            self.view = contentView.content
        }
        viewProtocol?.delegate = self
    }
    
    // MARK: - Actions
    
    @objc private func didTapOpenUserSettings() {
        flowProtocol?.presentPSUserProfile()
    }
}

// MARK: - Extensions

extension PSHomeViewController: PSHomeViewControllerProtocol {
    public func setupUI(with viewState: PSHomeViewState) {
        viewProtocol?.setupUI(with: viewState)
    }
}

extension PSHomeViewController: PSHomeViewViewControllerProtocol {
    public func didTapReload() {
        viewModelProtocol?.initState()
    }
    
    public func sendMessage(entity: PSHomeViewNewMessageEntity) {
        viewModelProtocol?.sendMessage(entity: entity)
    }
}
