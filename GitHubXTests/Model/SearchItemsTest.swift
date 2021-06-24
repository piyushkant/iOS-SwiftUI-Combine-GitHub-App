//
//  SearchItemsTest.swift
//  GitHubXTests
//
//  Created by Piyush Kant on 2021/06/13.
//

import XCTest
@testable import GitHubX

class SearchItemsTest: BaseTestCase {

    func test_model() {
        let sut = SearchItems(totalCount: testItemsCount, items: [testRepository])
        
        XCTAssertEqual(sut.totalCount, testItemsCount)
        XCTAssertEqual(sut.items.count, 1)
        XCTAssertEqual(sut.items[0], testRepository)
    }
}
