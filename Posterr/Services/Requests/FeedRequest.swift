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
        switch self {
        case let .postFeedMessage(postFeedMessageUseCaseEntity):
            return ["newMessage": postFeedMessageUseCaseEntity.message]
        case let .putUserInformation(putUserInformationUseCaseEntity):
            return ["newUserName": putUserInformationUseCaseEntity.userName]
        case .getFeedMessage, .getUserInformation:
            return nil
        }
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
        case .postFeedMessage:
            return "postFeedMessage"
        case .putUserInformation:
            return "putUserInformation"
        }
    }
}
