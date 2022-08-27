//
//  GetUserInformationUseCaseTest.swift
//  PosterrTests
//
//  Created by Lucas Carvalho on 27/08/22.
//

import Foundation
import XCTest
import RxSwift
@testable import Posterr

class PostFeedMessageUseCaseTests: XCTestCase {

    // MARK: - LifeCycle

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    // MARK: - Tests
   
    func testCallUseCase() throws {
        let network = NetworkOperation(mockData: nil)
        let useCase: PostFeedMessageUseCaseProtocol = PostFeedMessageUseCase(networking: network)
        let mockEntity = PostFeedMessageUseCaseEntity(message: "Teste", type: .normal, linkedMessage: nil)
        var resultRecived: Bool?

        useCase
            .execute(entity: mockEntity)
            .subscribe(onNext: { result in
                switch result {
                case .success:
                    resultRecived = true
                case .failure:
                    resultRecived = false
                }
            })
            .disposed(by: DisposeBag())

        let hasResult = try XCTUnwrap(resultRecived)
        XCTAssertTrue(hasResult)
    }
}
