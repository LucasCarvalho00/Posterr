//
//  GetUserInformationUseCase.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import RxSwift

public class GetUserInformationUseCase {
    
    //MARK: - Private Properties
    
    public typealias UseCaseEvent = Result<GetUserInformationUseCaseResponse, NetworkOperationError>
    private let networking: NetworkOperationProtocol

    //MARK: - Initializer
    
    public init(networking: NetworkOperationProtocol) {
        self.networking = networking
    }
}

//MARK: - Extension

extension GetUserInformationUseCase: GetUserInformationUseCaseProtocol {
    public func execute() -> Observable<Result<GetUserInformationUseCaseResponse, NetworkOperationError>> {
        let result = ReplaySubject<UseCaseEvent>.create(bufferSize: 1)
        networking.execute(
            request: FeedRequest.getUserInformation
        ) { (serviceResult: UseCaseEvent) in
            result.onNext(serviceResult)
            result.onCompleted()
        }
      
        return result
    }
}
