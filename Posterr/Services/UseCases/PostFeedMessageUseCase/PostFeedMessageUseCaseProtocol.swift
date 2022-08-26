//
//  PostFeedMessageUseCaseProtocol.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import RxSwift

public protocol PostFeedMessageUseCaseProtocol: AnyObject {
    func execute(entity: PostFeedMessageUseCaseEntity) -> Observable<Result<PostFeedMessageUseCaseResponse, NetworkOperationError>>
}
