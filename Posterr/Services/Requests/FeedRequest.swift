//
//  FeedRequest.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

enum FeedRequest: RequestProtocol {
    
    // MARK: - Case
    
    case getFeedMessage
    case getUserInformation
    case postFeedMessage
    case putUserInformation

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
            return "getFeed"
        case .getUserInformation:
            return "getUserInformation"
        case .postFeedMessage,
             .putUserInformation:
            return nil
        }
    }
}
