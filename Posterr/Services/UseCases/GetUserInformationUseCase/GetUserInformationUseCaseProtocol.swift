//
//  GetUserInformationUseCaseProtocol.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import RxSwift

public protocol GetUserInformationUseCaseProtocol: AnyObject {
    func execute() -> Observable<Result<GetUserInformationUseCaseResponse, NetworkOperationError>>
}
