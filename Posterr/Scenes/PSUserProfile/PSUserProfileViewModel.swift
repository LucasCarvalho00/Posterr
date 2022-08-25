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

    // MARK: - Initializer

    public init() {

    }
    
    // MARK: - Private Functions
}

// MARK: - Extensions

extension PSUserProfileViewModel: PSUserProfileViewModelProtocol {
    public func initState() {
        
    }
}
