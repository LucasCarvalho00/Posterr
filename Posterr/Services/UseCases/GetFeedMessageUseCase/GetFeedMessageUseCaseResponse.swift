//
//  GetFeedMessageUseCaseResponse.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

public struct GetFeedMessageUseCaseResponse: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let feeds: [GetFeedMessageResponse]?
}

public struct GetFeedMessageResponse: Decodable {
    let userID: Int
    let userAvatar: String
    let message: String
    let date: String
    let typeOfMessage: GetFeedMessageTypeResponse
    let linkedMessage: GetFeedLinkedMessageResponse?
}

public struct GetFeedLinkedMessageResponse: Decodable {
    let userID: Int
    let userAvatar: String
    let message: String
    let date: String
}

public enum GetFeedMessageTypeResponse: String, Decodable {
    case normal = "NORMAL"
    case reply = "REPLY"
    case quote = "QUOTE"
}
