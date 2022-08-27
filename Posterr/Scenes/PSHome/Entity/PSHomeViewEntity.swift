//
//  PSHomeViewEntity.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

import UIKit

public struct PSHomeViewEntity: Equatable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    var feeds: [PSHomeFeedMessageEntity]?
}

public struct PSHomeFeedMessageEntity: Equatable {
    let userID: Int
    let userAvatar: String
    let message: String
    let date: String
    let isMe: Bool
    let typeOfMessage: PSHomeFeedMessageTypeEntity
    let linkedMessage: PSHomeFeedLinkedMessageEntity?
}

public struct PSHomeFeedLinkedMessageEntity: Equatable {
    let userID: Int
    let userAvatar: String
    let message: String
    let date: String
}

public enum PSHomeFeedMessageTypeEntity: String, Equatable {
    case normal = "NORMAL"
    case reply = "REPLY"
    case quote = "QUOTE"
}
