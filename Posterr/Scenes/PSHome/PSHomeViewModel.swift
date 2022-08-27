//
//  PSHomeViewModel.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import RxSwift

public final class PSHomeViewModel {

    // MARK: - Constants

    private struct Metrics {
        static let mockCurrentUserID = 2
        static let maximiumMessagesPerDay = 7
    }
    
    private struct Constants {
        static let dateMask = "yyyy-MM-dd"
        static let dateDayMask = "dd"
        static let dateMonthMask = "MMMM"
        static let dateYearMask = "yyyy"
        static let mockUserAvatar = "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png"
    }

    
    // MARK: - Public Attributes

    public weak var viewController: PSHomeViewControllerProtocol?

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
        viewController?.setupUI(with: .loadScreen)
        callGetFeedMessageUseCase()
    }
    
    private func callGetFeedMessageUseCase() {
        getFeedMessageUseCaseProtocol
            .execute()
            .subscribe(onNext: { [weak self] result in
                switch result {
                case let .success(data):
                    guard let entity = self?.makePSHomeViewEntity(response: data) else {
                        return
                    }
                    
                    self?.viewController?.setupUI(with: .hasData(entity))
                    print("List received successfully")
                case let .failure(error):
                    self?.viewController?.setupUI(with: .hasError)
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func makePSHomeViewEntity(response: GetFeedMessageUseCaseResponse) -> PSHomeViewEntity {
        var feeds: [PSHomeFeedMessageEntity]? = []
        
        response.feeds?.forEach({ messageResponse in
            var linkedMessage: PSHomeFeedLinkedMessageEntity?
            
            if let linkedMessageResponse = messageResponse.linkedMessage {
                linkedMessage = PSHomeFeedLinkedMessageEntity(
                    userID: linkedMessageResponse.userID,
                    userAvatar: linkedMessageResponse.userAvatar,
                    message: linkedMessageResponse.message,
                    date: convertStringToFormatedDate(dateString: linkedMessageResponse.date)
                )
            }
            
            let messageEntity = PSHomeFeedMessageEntity(
                userID: messageResponse.userID,
                userAvatar: messageResponse.userAvatar,
                message: messageResponse.message,
                date: convertStringToFormatedDate(dateString: messageResponse.date),
                isMe: messageResponse.userID == Metrics.mockCurrentUserID,
                typeOfMessage: PSHomeFeedMessageTypeEntity(rawValue: messageResponse.typeOfMessage.rawValue) ?? .normal,
                linkedMessage: linkedMessage)
            
            feeds?.append(messageEntity)
        })
        
        return PSHomeViewEntity(
            page: response.page,
            totalPages: response.totalPages,
            totalResults: response.totalResults,
            feeds: feeds)
    }
    
    private func makeEntityPostFeedMessage(message: String) {
        let entity = PostFeedMessageUseCaseEntity(message: message)
        callPostFeedMessageUseCaseProtocol(entity: entity)
    }
    
    private func callPostFeedMessageUseCaseProtocol(entity: PostFeedMessageUseCaseEntity) {
        postFeedMessageUseCaseProtocol
            .execute(entity: entity)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case let .success(data):
                    self?.viewController?.setupUI(with: .messageSentSuccessfully)
                    self?.insertNewMessage(responseEntity: entity)
                    print(data.message)
                case let .failure(error):
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func insertNewMessage(responseEntity: PostFeedMessageUseCaseEntity) {
        let newMessageEntity = PSHomeFeedMessageEntity(
            userID: Metrics.mockCurrentUserID,
            userAvatar: Constants.mockUserAvatar,
            message: responseEntity.message,
            date: convertStringToFormatedDate(dateString: Date().description),
            isMe: true,
            typeOfMessage: .normal,
            linkedMessage: nil)
        
        viewController?.setupUI(with: .insertNewMessage(newMessageEntity))
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

extension PSHomeViewModel: PSHomeViewModelProtocol {
    public func initState() {
        initScreen()
    }
    
    public func sendMessage(message: String) {
        makeEntityPostFeedMessage(message: message)
    }
}
