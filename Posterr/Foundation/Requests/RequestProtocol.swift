//
//  RequestProtocol.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

public protocol RequestProtocol {
    var path: String { get }
    var method: NetworkingRequestMethod { get }
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
    var requestMock: String? { get }
}
