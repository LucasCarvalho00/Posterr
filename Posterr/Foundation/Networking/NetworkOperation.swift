//
//  NetworkOperation.swift
//  Posterr
//
//  Created by Lucas Carvalho on 25/08/22.
//

import RxSwift

public final class NetworkOperation {

    // MARK: - Private Attributes

    private let baseURL: String = "https://urlbasehardcoded.com/"
    private let mockData: String?

    // MARK: - Setup

    init(mockData: String? = nil) {
        self.mockData = mockData
    }
    
    // MARK: - Private Functions

    private func executeNetwork<T: Decodable>(request: RequestProtocol, completion: @escaping (Result<T, NetworkOperationError>) -> Void) {
        let apiStringURL = baseURL + request.path
            
        guard let apiURL = self.getURL(apiStringURL: apiStringURL, request: request) else {
            completion(.failure(.noURL))
            return
        }
                
        var urlRequest = URLRequest(url: apiURL)
            for (key,value) in self.getNetworkHeaders() {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
            
        if let headersRequest = request.headers {
            for (key,value) in headersRequest {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
            
        if let parameters = request.parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            } catch {
                completion(.failure(.erroParameters))
            }
        }
        
        urlRequest.httpMethod = request.method.rawValue
            
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
            
            self.parseObject(jsonData: jsonData, completion: completion)
        }
                    
        task.resume()
    }
    
    private func executeMockNetwork<T: Decodable>(mockData: String, completion: @escaping (Result<T, NetworkOperationError>) -> Void) {
    
        guard let jsonData = getData(name: mockData) else {
            completion(.failure(.noData))
            return
        }
        
        parseObject(jsonData: jsonData, completion: completion)
    }
    
    private func parseObject<T: Decodable>(jsonData: Data, completion: @escaping (Result<T, NetworkOperationError>) -> Void) {
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: jsonData)
            completion(.success(decoded))
        } catch {
            completion(.failure(.erroParsable))
        }
    }
}

// MARK: - Extensions

extension NetworkOperation: NetworkOperationProtocol {
    public func execute<T: Decodable>(request: RequestProtocol, completion: @escaping (Result<T, NetworkOperationError>) -> Void) {
        if let mockData = mockData ?? request.requestMock {
            executeMockNetwork(mockData: mockData, completion: completion)
        } else {
            executeNetwork(request: request, completion: completion)
        }
    }
}
