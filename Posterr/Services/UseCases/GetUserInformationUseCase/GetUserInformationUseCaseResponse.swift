//
//  GetUserInformationUseCaseResponse.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

public struct GetUserInformationUseCaseResponse: Decodable {
    let statusCode: Int
    let message: String
}
