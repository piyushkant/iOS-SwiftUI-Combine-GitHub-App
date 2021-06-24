//
//  BaseTestCase.swift
//  GitHubXTests
//
//  Created by Piyush Kant on 2021/06/13.
//

import XCTest
import Combine

@testable import GitHubX

class BaseTestCase: XCTestCase {
    
    let testPerPage = 20
    let testItemsCount = 1
    let testRepositoryID = 1
    let testRepositoryName = "iOS-RxSwift-MVVM-Chat-App"
    let testRepositoryURL = "https://github.com/piyushkant/iOS-RxSwift-MVVM-Chat-App"
    let testQuery = "query"
    let testErrorMessage = "Test error message"
   
    var testRepository: Repository {
        Repository(id: testRepositoryID, name: testRepositoryName, url: testRepositoryURL)
    }
    
    var cancellables = Set<AnyCancellable>()
    
    let mockAPI = MockAPI()
    
    var mockRepositoryService: RepositoryServiceProtocol {
        RepositoryService(api: mockAPI)
    }
    
    func mockListViewModel(isLoading: Bool = false, errorMessage: String = "", repositories: [Repository] = [], query: String = "") -> RepositoryListViewModel {
        let result = RepositoryListViewModel(repositoryService: mockRepositoryService, debounceInterval: 0)
        result.isLoading = isLoading
        result.errorMessage = errorMessage
        result.repositories = repositories
        result.query = query
        return result
    }
    
    // MARK: - Helpers
    
    func waitOrFail(timeout: TimeInterval) {
        let expectation = self.expectation(description: #function)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeout, execute: {
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: timeout + 2)
    }
}

extension Repository: Equatable {
    public static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.url == rhs.url
    }
}


