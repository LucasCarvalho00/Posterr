//
//  GetUserInformationUseCaseResponse.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

public struct GetUserInformationUseCaseResponse: Decodable {
    let userID: Int
    let userName: String
    let totalMessages: Int
    let createdDate: String
    let totalTodayMessages: Int
    let userAvatar: String
}
