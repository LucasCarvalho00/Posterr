//
//  PSUserProfileViewModel.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import RxSwift

public final class PSUserProfileViewModel {
    
    // MARK: - Constants

    private struct Constants {
        static let dateMask = "yyyy-MM-dd"
        static let dateDayMask = "dd"
        static let dateMonthMask = "MMMM"
        static let dateYearMask = "yyyy"
    }
    
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
                    guard let entity = self?.makePSUserProfileViewEntity(response: data) else {
                        return
                    }

                    self?.viewController?.setupUI(with: .hasData(entity))
                    print("User information received successfully")
                case let .failure(error):
                    self?.viewController?.setupUI(with: .hasError)
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func makePSUserProfileViewEntity(response: GetUserInformationUseCaseResponse) -> PSUserProfileViewEntity {
        PSUserProfileViewEntity(
            userID: response.userID,
            userName: response.userName,
            totalMessages: response.totalMessages,
            createdDate: convertStringToFormatedDate(dateString: response.createdDate),
            totalTodayMessages: response.totalTodayMessages,
            userAvatar: response.userAvatar)
    }
    
    private func convertStringToFormatedDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateMask
        let date = dateFormatter.date(from: dateString) ?? Date()
        
        dateFormatter.dateFormat = Constants.dateYearMask
        let year = dateFormatter.string(from: date)
        dateFormatter.dateFormat = Constants.dateMonthMask
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = Constants.dateDayMask
        let day = dateFormatter.string(from: date)
    
        return month.capitalized + " " + day + ", " + year
    }
}

// MARK: - Extensions

extension PSUserProfileViewModel: PSUserProfileViewModelProtocol {
    public func initState() {
        initScreen()
    }
}
