//
//  NetworkOperationDefaultParameters.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import Foundation
import UIKit

extension NetworkOperation {
    func getNetworkHeaders() -> [String: String] {
        let headers: [String: String] = [
           "apiVersion": "1",
           "Content-type": "application/json",
           "Accept-Language": Locale.current.languageCode ?? "",
           "appVersion": "1",
           "platform": "iOS",
        ]
        
        return headers
    }
    
    func getURL(apiStringURL: String, request: RequestProtocol) -> URL? {
        switch request.method {
        case .GET:
            guard var components = URLComponents(string: apiStringURL) else {
                return nil
            }
            
            if let parameters = request.parameters {
                var queryItens: [URLQueryItem] = []
                for (key, value) in parameters {
                    queryItens.append(URLQueryItem(name: key, value: value))
                }
                components.queryItems = queryItens
            }
            
            return components.url
        default:
            return URL(string: apiStringURL)
        }
    }
    
    func getData(name: String, withExtension: String = "json") -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: name, withExtension: withExtension) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            return data
        } catch {
            return nil
        }
    }
}
