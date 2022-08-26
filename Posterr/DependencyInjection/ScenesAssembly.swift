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
            let getFeedMessageUseCaseProtocol = resolver.resolve(GetFeedMessageUseCaseProtocol.self)!
            let postFeedMessageUseCaseProtocol = resolver.resolve(PostFeedMessageUseCaseProtocol.self)!

            return PSHomeViewModel(
                getFeedMessageUseCaseProtocol: getFeedMessageUseCaseProtocol,
                postFeedMessageUseCaseProtocol: postFeedMessageUseCaseProtocol)
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
            let getUserInformationUseCaseProtocol = resolver.resolve(GetUserInformationUseCaseProtocol.self)!
            let putUserInformationUseCaseProtocol = resolver.resolve(PutUserInformationUseCaseProtocol.self)!
            
            return PSUserProfileViewModel(
                getUserInformationUseCaseProtocol: getUserInformationUseCaseProtocol,
                putUserInformationUseCaseProtocol: putUserInformationUseCaseProtocol)
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
        
        // MARK: - GetFeedMessageUseCase

        container.register(GetFeedMessageUseCaseProtocol.self) { resolver in
            let networkManager = resolver.resolve(NetworkOperationProtocol.self)!
            return GetFeedMessageUseCase(networking: networkManager)
        }
        
        // MARK: - GetUserInformationUseCase

        container.register( GetUserInformationUseCaseProtocol.self) { resolver in
            let networkManager = resolver.resolve(NetworkOperationProtocol.self)!
            return  GetUserInformationUseCase(networking: networkManager)
        }
        
        // MARK: - PostFeedMessageUseCase

        container.register(PostFeedMessageUseCaseProtocol.self) { resolver in
            let networkManager = resolver.resolve(NetworkOperationProtocol.self)!
            return PostFeedMessageUseCase(networking: networkManager)
        }
        
        // MARK: - PutUserInformationUseCase

        container.register(PutUserInformationUseCaseProtocol.self) { resolver in
            let networkManager = resolver.resolve(NetworkOperationProtocol.self)!
            return PutUserInformationUseCase(networking: networkManager)
        }
    }
}
