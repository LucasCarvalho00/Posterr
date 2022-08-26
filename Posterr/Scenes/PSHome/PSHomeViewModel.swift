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
                    message: linkedMessageResponse.message)
            }
            
            let messageEntity = PSHomeFeedMessageEntity(
                userID: messageResponse.userID,
                userAvatar: messageResponse.userAvatar,
                message: messageResponse.message,
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
                    print(data.message)
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
    
    public func sendMessage(message: String) {
        makeEntityPostFeedMessage(message: message)
    }
}
