//
//  FlowController.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import UIKit

final class FlowController {
    
    // MARK: - Private Attributes

    private let factory: ScenesFactoryProtocol
    
    // MARK: - Public Attributes

    public weak var navigationController: UINavigationController?

    // MARK: - Setup

    public init(navigationController: UINavigationController,
                factory: ScenesFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
        
    // MARK: - Public Functions

    public func start() {
//        let viewController = factory.makePSHomeViewController()
        let viewController = factory.makePSUserProfileViewController()

        viewController.flowProtocol = self
        navigationController?.setViewControllers([viewController], animated: true)
    }
}

// MARK: - Extension

extension FlowController: PSHomeViewFlowProtocol {
    func presentPSUserProfile() {
        let viewController = factory.makePSUserProfileViewController()
        viewController.flowProtocol = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FlowController: PSUserProfileViewFlowProtocol { }
