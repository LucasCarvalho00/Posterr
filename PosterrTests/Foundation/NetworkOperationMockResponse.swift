//
//  NetworkOperationMockResponse.swift
//  PosterrTests
//
//  Created by Lucas Carvalho on 27/08/22.
//

import Foundation

struct NetworkOperationMockResponse: Codable {
    let cards: [NetworkOperationListMockResponse]
}

struct NetworkOperationListMockResponse: Codable {
    let id: Int
    let productId: Int
    let type: String
    let title: String?
    let number: String?
}
