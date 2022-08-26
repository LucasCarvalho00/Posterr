//
//  PSHomeViewModel.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import RxSwift

public final class PSHomeViewModel {

    // MARK: - Public Attributes

    public weak var viewController: PSHomeViewControllerProtocol?
    var entity: PSHomeViewEntity?

    // MARK: - Private Properties

    private let getFeedMessageUseCaseProtocol: GetFeedMessageUseCaseProtocol
    private let postFeedMessageUseCaseProtocol: PostFeedMessageUseCaseProtocol
    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    public init(
        getFeedMessageUseCaseProtocol: GetFeedMessageUseCaseProtocol,
        postFeedMessageUseCaseProtocol: PostFeedMessageUseCaseProtocol
    ) {
        self.getFeedMessageUseCaseProtocol = getFeedMessageUseCaseProtocol
        self.postFeedMessageUseCaseProtocol = postFeedMessageUseCaseProtocol
    }
    
    // MARK: - Private Functions
    
    private func initScreen() {
        callGetFeedMessageUseCase()
    }
    
    private func callGetFeedMessageUseCase() {
        getFeedMessageUseCaseProtocol
            .execute()
            .subscribe(onNext: { [weak self] result in
                switch result {
                case let .success(data):
                    print("data")
                case let .failure(error):
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Extensions

extension PSHomeViewModel: PSHomeViewModelProtocol {
    public func initState() {
        initScreen()
    }
}
