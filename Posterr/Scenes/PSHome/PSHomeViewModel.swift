//
//  PSHomeViewModel.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

public final class PSHomeViewModel {

    // MARK: - Public Attributes

    public weak var viewController: PSHomeViewControllerProtocol?
    var entity: PSHomeViewEntity?

    // MARK: - Initializer

    public init() {

    }
    
    // MARK: - Private Functions
}

// MARK: - Extensions

extension PSHomeViewModel: PSHomeViewModelProtocol {
    public func initState() {
        
    }
}
