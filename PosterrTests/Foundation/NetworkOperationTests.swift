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

    // MARK: - Private Functions

    private func getData(name: String, withExtension: String = "json") -> Data? {
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

    // MARK: - Tests
    
    func testNetworkMockWithURL() throws {
        let mockURL = "https://run.mocky.io/v3/d26d86ec-fb82-48a7-9c73-69e2cb728070"
        let network: NetworkOperationProtocol = NetworkOperation(mockURL: mockURL)

        network.fetchNetwork(request: ListRequests.getGenreMovie) { (result: Result<ContactMockResponse, NetworkOperationError>) in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
    
    
    func testNetworkParseObjectSuccessfully() throws {
        guard let data = getData(name: "cardsSuccessfullyMock") else {
            XCTAssertTrue(false,"No data")
            return
        }
        
        let network: NetworkOperationProtocol = NetworkMockOperation(mockData: data)
        var resultRecived: Bool?

        network.fetchNetwork(request: ListRequests.getGenreMovie) { (result: Result<NetworkOperationMockResponse, NetworkOperationError>) in
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
        guard let data = getData(name: "cardsErrorMock") else {
            XCTAssertTrue(false,"No data")
            return
        }
        
        let network: NetworkOperationProtocol = NetworkMockOperation(mockData: data)
        var resultRecived: Bool?

        network.fetchNetwork(request: ListRequests.getGenreMovie) { (result: Result<CardsMockResponse, NetworkOperationError>) in
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
}
