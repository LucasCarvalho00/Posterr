//
//  PutUserInformationUseCase.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import RxSwift

public class PutUserInformationUseCase {
    
    //MARK: - Private Properties
    
    public typealias UseCaseEvent = Result<PutUserInformationUseCaseResponse, NetworkOperationError>
    private let networking: NetworkOperationProtocol

    //MARK: - Initializer
    
    public init(networking: NetworkOperationProtocol) {
        self.networking = networking
    }
}

//MARK: - Extension

extension PutUserInformationUseCase: PutUserInformationUseCaseProtocol {
    public func execute(entity: PutUserInformationUseCaseEntity) -> Observable<Result<PutUserInformationUseCaseResponse, NetworkOperationError>> {
        let result = ReplaySubject<UseCaseEvent>.create(bufferSize: 1)
        networking.execute(
            request: FeedRequest.putUserInformation(entity)
        ) { (serviceResult: UseCaseEvent) in
            result.onNext(serviceResult)
            result.onCompleted()
        }
      
        return result
    }
}
