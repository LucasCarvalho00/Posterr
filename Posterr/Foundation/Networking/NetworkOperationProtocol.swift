//
//  NetworkOperationProtocol.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import RxSwift

public protocol NetworkOperationProtocol {
    func execute<T: Decodable>(request: RequestProtocol, completion: @escaping (Result<T, NetworkOperationError>) -> Void)
}
