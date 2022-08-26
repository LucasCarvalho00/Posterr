//
//  PSUserProfileViewController.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import Foundation
import UIKit

public final class PSUserProfileViewController: UIViewController {

    // MARK: - Public Attributes

    public let viewProtocol: PSUserProfileViewProtocol?
    public let viewModelProtocol: PSUserProfileViewModelProtocol?
    public var flowProtocol: PSUserProfileViewFlowProtocol?

    // MARK: - Initializer

    public init(
        viewProtocol: PSUserProfileViewProtocol,
        viewModelProtocol: PSUserProfileViewModelProtocol
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
    }

    // MARK: - Private Functions

    private func setup() {
        
    }

    private func contentSetup() {
        if let contentView = viewProtocol {
            self.view = contentView.content
        }
        viewProtocol?.delegate = self
    }
}

// MARK: - Extensions

extension PSUserProfileViewController: PSUserProfileViewControllerProtocol {
    public func setupUI(with viewState: PSUserProfileViewState) {
        viewProtocol?.setupUI(with: viewState)
    }
}

extension PSUserProfileViewController: PSUserProfileViewViewControllerProtocol { }
