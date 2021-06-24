//
//  APIEndpointTest.swift
//  GitHubXTests
//
//  Created by Piyush Kant on 2021/06/13.
//

import XCTest
import Combine

@testable import GitHubX

class APIEndpointTest: BaseTestCase {
    
    func test_urlRequest() {
        let sut = APIEndpoint.searchRepository(query: testQuery, perPage: testPerPage).request

        XCTAssertEqual(sut.url!.absoluteString, APIEndpoint.baseURL + "search/repositories?q=\(testQuery)&per_page=\(testPerPage)")
    }
}
