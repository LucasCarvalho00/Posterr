//
//  PSUserProfileViewModel.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import RxSwift

public final class PSUserProfileViewModel {

    // MARK: - Public Attributes

    public weak var viewController: PSUserProfileViewControllerProtocol?
    private var entity: PSUserProfileViewEntity?
    private let disposeBag = DisposeBag()

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
    
    private func initScreen() {
        viewController?.setupUI(with: .loadScreen)
        callGetUserInformationUseCase()
    }
    
    private func callGetUserInformationUseCase() {
        getUserInformationUseCaseProtocol
            .execute()
            .subscribe(onNext: { [weak self] result in
                switch result {
                case let .success(data):
//                    guard let entity = self?.makePSHomeViewEntity(response: data) else {
//                        return
//                    }
//
//                    self?.viewController?.setupUI(with: .hasData(entity))
                    print("User received successfully")
                case let .failure(error):
                    self?.viewController?.setupUI(with: .hasError)
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Extensions

extension PSUserProfileViewModel: PSUserProfileViewModelProtocol {
    public func initState() {
        initScreen()
    }
}
