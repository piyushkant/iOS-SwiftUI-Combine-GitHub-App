//
//  MockAPI.swift
//  GitHubXTests
//
//  Created by Piyush Kant on 2021/06/13.
//

import XCTest
import Combine

@testable import GitHubX

class MockAPI: APIProtocol {
    
    private var mockSearchItems: SearchItems {
        let repository = Repository(id: 1, name: "iOS-RxSwift-MVVM-Chat-App", url: "https://github.com/piyushkant/iOS-RxSwift-MVVM-Chat-App")
        return SearchItems(totalCount: 1, items: [repository])
    }
    
    func fetchRepositories(query: String, perPage: Int) -> AnyPublisher<SearchItems, APIError> {
        return Just(mockSearchItems)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
