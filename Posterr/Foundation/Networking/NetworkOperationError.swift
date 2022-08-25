//
//  NetworkOperationError.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

public enum NetworkOperationError: Error {
    
    // MARK: - Case

    case noData
    case erroParsable
    case noURL
    case erroParameters
    case noInternetConnection
    
    // MARK: - Properties

    var text: String {
        switch self {
        case .noData:
            return ""
        case .erroParsable:
            return ""
        case .noURL:
            return ""
        case .erroParameters:
            return ""
        case .noInternetConnection:
            return ""
        }
    }
    
    var errorCode: Int {
        switch self {
        case .noData:
            return 01
        case .erroParsable:
            return 02
        case .noURL:
            return 03
        case .erroParameters:
            return 04
        case .noInternetConnection:
            return 05
        }
    }
}
