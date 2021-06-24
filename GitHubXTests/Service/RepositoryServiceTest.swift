//
//  RepositoryServiceTest.swift
//  GitHubXTests
//
//  Created by Piyush Kant on 2021/06/13.
//

import XCTest
import Combine

@testable import GitHubX

class RepositoryServiceTest: BaseTestCase {
    
    func test_fetchRepositories() {
        let sut = mockRepositoryService
        
        sut.fetchRepositories(query: testQuery)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { repositories in
                XCTAssertEqual(repositories, [self.testRepository])
            }
            .store(in: &cancellables)
        
        waitOrFail(timeout: 0.1)
    }
}
