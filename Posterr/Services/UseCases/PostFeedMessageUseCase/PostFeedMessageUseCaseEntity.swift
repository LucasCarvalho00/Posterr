//
//  PostFeedMessageUseCaseEntity.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

public struct PostFeedMessageUseCaseEntity {
    let message: String
    let type: PostLinkedFeedUseCaseTypeEntity
    let linkedMessage: PostLinkedFeedUseCaseEntity?
}

public struct PostLinkedFeedUseCaseEntity: Equatable {
    let userID: Int
    let userAvatar: String
    let message: String
    let date: String
}

public enum PostLinkedFeedUseCaseTypeEntity: String, Decodable {
    case normal = "NORMAL"
    case reply = "REPLY"
    case quote = "QUOTE"
}
