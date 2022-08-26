//
//  GetFeedMessageUseCaseResponse.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

public struct GetFeedMessageUseCaseResponse: Decodable {
    let statusCode: Int
    let message: String
}
