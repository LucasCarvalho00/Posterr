//
//  PSUserProfileViewModel.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

public final class PSUserProfileViewModel {

    // MARK: - Public Attributes

    public weak var viewController: PSUserProfileViewControllerProtocol?
    var entity: PSUserProfileViewEntity?

    // MARK: - Private Properties

    private let getUserInformationUseCaseProtocol: GetUserInformationUseCaseProtocol
    private let putUserInformationUseCaseProtocol: PutUserInformationUseCaseProtocol

    // MARK: - Initializer

    public init(
        getUserInformationUseCaseProtocol: GetUserInformationUseCaseProtocol,
        putUserInformationUseCaseProtocol: PutUserInformationUseCaseProtocol
    ) {
        self.getUserInformationUseCaseProtocol = getUserInformationUseCaseProtocol
        self.putUserInformationUseCaseProtocol = putUserInformationUseCaseProtocol
    }
    
    // MARK: - Private Functions
}

// MARK: - Extensions

extension PSUserProfileViewModel: PSUserProfileViewModelProtocol {
    public func initState() {
        
    }
}
