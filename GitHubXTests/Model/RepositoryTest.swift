//
//  RepositoryTest.swift
//  GitHubXTests
//
//  Created by Piyush Kant on 2021/06/13.
//

import XCTest
@testable import GitHubX

class RepositoryTest: BaseTestCase {

    func test_model() {
        XCTAssertEqual(testRepository.id, testRepositoryID)
        XCTAssertEqual(testRepository.name, testRepositoryName)
        XCTAssertEqual(testRepository.url, testRepositoryURL)
    }
}
