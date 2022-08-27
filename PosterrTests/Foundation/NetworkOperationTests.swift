//
//  NetworkOperationTests.swift
//  PosterrTests
//
//  Created by Lucas Carvalho on 27/08/22.
//

import Foundation
import XCTest
@testable import Posterr

class NetworkOperationTests: XCTestCase {

    // MARK: - LifeCycle

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    // MARK: - Tests
    
    func testParseObject() throws {
        guard let data = Commons().getData(name: "NetworkOperationMock") else {
            XCTAssertTrue(false,"No data")
            return
        }
        
        let network = NetworkOperation(mockData: nil)
        var resultRecived: Bool?

        network.parseObject(jsonData: data) { (result: Result<NetworkOperationMockResponse, NetworkOperationError>) in
            switch result {
            case .success:
                resultRecived = true
            case .failure:
                resultRecived = false
            }
        }

        let hasResult = try XCTUnwrap(resultRecived)
        XCTAssertTrue(hasResult)
    }
    
    func testNetworkParseObjectError() throws {
        guard let data = Commons().getData(name: "NetworkOperationErrorMock") else {
            XCTAssertTrue(false,"No data")
            return
        }
        
        let network = NetworkOperation(mockData: nil)
        var resultRecived: Bool?

        network.parseObject(jsonData: data) { (result: Result<NetworkOperationMockResponse, NetworkOperationError>) in
            switch result {
            case .success:
                resultRecived = false
            case .failure:
                resultRecived = true
            }
        }

        let hasResult = try XCTUnwrap(resultRecived)
        XCTAssertTrue(hasResult)
    }
    
    func testCallNetwork() throws {
        let network = NetworkOperation(mockData: "getFeed")
        var resultRecived: Bool?

        network.execute(request: FeedRequest.getFeedMessage) { (result: Result<GetFeedMessageUseCaseResponse, NetworkOperationError>) in
            switch result {
            case .success:
                resultRecived = true
            case .failure:
                resultRecived = false
            }
        }

        let hasResult = try XCTUnwrap(resultRecived)
        XCTAssertTrue(hasResult)
    }
}
