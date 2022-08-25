//
//  ScenesAssembly.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import Swinject

final class ScenesAssembly: Assembly {
    func assemble(container: Container) {
        
        // MARK: - PSHomeView
        
        container.register(PSHomeViewModelProtocol.self) { resolver in
            PSHomeViewModel()
        }
        
        container.register(PSHomeViewProtocol.self) { resolver in
            PSHomeView()
        }
        
        container.register(PSHomeViewController.self) { resolver in
            let view = resolver.resolve(PSHomeViewProtocol.self)!
            let viewModel = resolver.resolve(PSHomeViewModelProtocol.self)!
            let viewController = PSHomeViewController(viewProtocol: view, viewModelProtocol: viewModel)
            viewModel.viewController = viewController
            return viewController
        }
        
        // MARK: - PSUserProfile
        
        container.register(PSUserProfileViewModelProtocol.self) { resolver in
            PSUserProfileViewModel()
        }
        
        container.register(PSUserProfileViewProtocol.self) { resolver in
            PSUserProfileView()
        }
        
        container.register(PSUserProfileViewController.self) { resolver in
            let view = resolver.resolve(PSUserProfileViewProtocol.self)!
            let viewModel = resolver.resolve(PSUserProfileViewModelProtocol.self)!
            let viewController = PSUserProfileViewController(viewProtocol: view, viewModelProtocol: viewModel)
            viewModel.viewController = viewController
            return viewController
        }
    }
}
