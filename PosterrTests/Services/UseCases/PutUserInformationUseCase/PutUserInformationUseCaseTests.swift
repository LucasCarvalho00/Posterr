//
//  PutUserInformationUseCaseTest.swift
//  PosterrTests
//
//  Created by Lucas Carvalho on 27/08/22.
//

import Foundation
import XCTest
import RxSwift
@testable import Posterr

class PutUserInformationUseCaseTests: XCTestCase {

    // MARK: - LifeCycle

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    // MARK: - Tests
   
    func testCallUseCase() throws {
        let network = NetworkOperation(mockData: nil)
        let useCase: PutUserInformationUseCaseProtocol = PutUserInformationUseCase(networking: network)
        let mockEntity = PutUserInformationUseCaseEntity(userName: "name")
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
