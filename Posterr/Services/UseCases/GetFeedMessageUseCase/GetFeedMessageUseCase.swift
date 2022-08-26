//
//  GetFeedMessageUseCase.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import RxSwift

public class GetFeedMessageUseCase {
    
    //MARK: - Private Properties
    
    public typealias UseCaseEvent = Result<GetFeedMessageUseCaseResponse, NetworkOperationError>
    private let networking: NetworkOperationProtocol

    //MARK: - Initializer
    
    public init(networking: NetworkOperationProtocol) {
        self.networking = networking
    }
}

//MARK: - Extension

extension GetFeedMessageUseCase: GetFeedMessageUseCaseProtocol {
    public func execute() -> Observable<Result<GetFeedMessageUseCaseResponse, NetworkOperationError>> {
        let result = ReplaySubject<UseCaseEvent>.create(bufferSize: 1)
        networking.execute(
            request: FeedRequest.getFeedMessage
        ) { (serviceResult: UseCaseEvent) in
            result.onNext(serviceResult)
            result.onCompleted()
        }
      
        return result
    }
}
