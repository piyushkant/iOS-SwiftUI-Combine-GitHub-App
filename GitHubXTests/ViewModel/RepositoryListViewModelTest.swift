//
//  RepositoryListViewModelTest.swift
//  GitHubXTests
//
//  Created by Piyush Kant on 2021/06/13.
//

import XCTest
import Combine

@testable import GitHubX

class RepositoryListViewModelTest: BaseTestCase {
        
    func test_clear() {
        let sut = mockListViewModel(isLoading: true, errorMessage: testErrorMessage, repositories: [testRepository])
        
        sut.clear()
        
        XCTAssertEqual(sut.repositories, [])
        XCTAssertEqual(sut.errorMessage, "")
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_fetchRepositories_isNotStartedWithTwoCharacters() {
        let sut = mockListViewModel(query: "io")

        sut.fetchRepositories()
        waitOrFail(timeout: 0.1)

        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.repositories, [])
    }
    
    func test_fetchRepositories_isStartedWithThreeCharacters() {
        let sut = mockListViewModel(query: "ios")

        sut.fetchRepositories()
        waitOrFail(timeout: 0.1)

        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.repositories, [testRepository])
    }
}


