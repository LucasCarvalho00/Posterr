//
//  PSHomeViewNewMessageEntity.swift
//  Posterr
//
//  Created by Lucas Carvalho on 26/08/22.
//

import Foundation

public struct PSHomeViewNewMessageEntity: Equatable {
    let message: String
    let typeMessage: PSHomeViewNewMessageTypeEntity
    let linkedMessage: PSHomeFeedNewLinkedMessageEntity?
}

public struct PSHomeFeedNewLinkedMessageEntity: Equatable {
    let userID: Int
    let userAvatar: String
    let message: String
    let date: String
}

public enum PSHomeViewNewMessageTypeEntity: String, Decodable {
    case normal = "NORMAL"
    case reply = "REPLY"
    case quote = "QUOTE"
}
