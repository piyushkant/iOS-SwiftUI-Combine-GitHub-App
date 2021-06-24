//
//  RepositoryService.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import Combine

protocol RepositoryServiceProtocol {
    func fetchRepositories(query: String) -> AnyPublisher<[Repository], APIError>
}

class RepositoryService: RepositoryServiceProtocol {
    
    private let api: APIProtocol
    
    init(api: APIProtocol) {
        self.api = api
    }
    
    func fetchRepositories(query: String) -> AnyPublisher<[Repository], APIError> {
        api
            .fetchRepositories(query: query, perPage: AppConfig.perPage)
            .flatMap {
                Just($0.items)
                    .setFailureType(to: APIError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
