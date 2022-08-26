//
//  PSHomeViewEntity.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

public struct PSHomeViewEntity: Equatable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let feeds: [PSHomeFeedMessageEntity]?
}

public struct PSHomeFeedMessageEntity: Equatable {
    let userID: Int
    let userAvatar: String
    let message: String
    let typeOfMessage: PSHomeFeedMessageTypeEntity
    let linkedMessage: PSHomeFeedLinkedMessageEntity?
}

public struct PSHomeFeedLinkedMessageEntity: Equatable {
    let userID: Int
    let userAvatar: String
    let message: String
}

public enum PSHomeFeedMessageTypeEntity: String, Equatable {
    case normal = "NORMAL"
    case reply = "REPLY"
    case quote = "QUOTE"
}
