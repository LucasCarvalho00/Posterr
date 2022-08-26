//
//  PostFeedMessageUseCase.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import RxSwift

public class PostFeedMessageUseCase {
    
    //MARK: - Private Properties
    
    public typealias UseCaseEvent = Result<PostFeedMessageUseCaseResponse, NetworkOperationError>
    private let networking: NetworkOperationProtocol

    //MARK: - Initializer
    
    public init(networking: NetworkOperationProtocol) {
        self.networking = networking
    }
}

//MARK: - Extension

extension PostFeedMessageUseCase: PostFeedMessageUseCaseProtocol {
    public func execute(entity: PostFeedMessageUseCaseEntity) -> Observable<Result<PostFeedMessageUseCaseResponse, NetworkOperationError>> {
        let result = ReplaySubject<UseCaseEvent>.create(bufferSize: 1)
        networking.execute(
            request: FeedRequest.postFeedMessage(entity)
        ) { (serviceResult: UseCaseEvent) in
            result.onNext(serviceResult)
            result.onCompleted()
        }
      
        return result
    }
}
