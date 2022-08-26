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

    // MARK: - Private Properties

    private let getFeedMessageUseCaseProtocol: GetFeedMessageUseCaseProtocol
    private let postFeedMessageUseCaseProtocol: PostFeedMessageUseCaseProtocol

    // MARK: - Initializer

    public init(
        getFeedMessageUseCaseProtocol: GetFeedMessageUseCaseProtocol,
        postFeedMessageUseCaseProtocol: PostFeedMessageUseCaseProtocol
    ) {
        self.getFeedMessageUseCaseProtocol = getFeedMessageUseCaseProtocol
        self.postFeedMessageUseCaseProtocol = postFeedMessageUseCaseProtocol
    }
    
    // MARK: - Private Functions
}

// MARK: - Extensions

extension PSHomeViewModel: PSHomeViewModelProtocol {
    public func initState() {
        
    }
}
