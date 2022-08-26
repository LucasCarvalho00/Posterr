//
//  PutUserInformationUseCaseProtocol.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import RxSwift

public protocol PutUserInformationUseCaseProtocol: AnyObject {
    func execute(entity: PutUserInformationUseCaseEntity) -> Observable<Result<PutUserInformationUseCaseResponse, NetworkOperationError>>
}
