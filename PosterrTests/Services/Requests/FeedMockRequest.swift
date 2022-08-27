//
//  FeedMockRequest.swift
//  PosterrTests
//
//  Created by Lucas Carvalho on 27/08/22.
//

import Posterr

enum FeedMockRequest: RequestProtocol {
    
    // MARK: - Case
    
    case getFeedMessage
    case getUserInformation
    case postFeedMessage(PostFeedMessageUseCaseEntity)
    case putUserInformation(PutUserInformationUseCaseEntity)

    // MARK: - Properties
    
    var path: String {
        switch self {
        case .getFeedMessage:
            return "private/user/feed"
        case .getUserInformation:
            return "private/user/information"
        case .postFeedMessage:
            return "private/user/feed"
        case .putUserInformation:
            return "private/user/information"
        }
    }
    
    var method: NetworkingRequestMethod {
        switch self {
        case .getFeedMessage,
             .getUserInformation:
            return .GET
        case .postFeedMessage:
            return .POST
        case .putUserInformation:
            return .PUT
        }
    }
    
    var parameters: [String: String]? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var requestMock: String? {
        switch self {
        case .getFeedMessage:
            return "getMockFeed"
        case .getUserInformation:
            return "getMockUserInformation"
        case .postFeedMessage:
            return "postMockFeedMessage"
        case .putUserInformation:
            return "putMockUserInformation"
        }
    }
}
