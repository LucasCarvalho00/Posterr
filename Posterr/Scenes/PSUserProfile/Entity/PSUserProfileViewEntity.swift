//
//  PSUserProfileViewEntity.swift
//  Posterr
//
//  Created by Lucas Carvalho on 24/08/22.
//

public struct PSUserProfileViewEntity: Equatable {
    let userID: Int
    let userName: String
    let totalMessages: Int
    let createdDate: String
    let totalTodayMessages: Int
    let userAvatar: String
}
