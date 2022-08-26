//
//  GetFeedMessageUseCaseProtocol.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import RxSwift

public protocol GetFeedMessageUseCaseProtocol: AnyObject {
    func execute() -> Observable<Result<GetFeedMessageUseCaseResponse, NetworkOperationError>>
}
