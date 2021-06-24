//
//  RepositoryListViewModel.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import Foundation
import Combine

class RepositoryListViewModel: ObservableObject {
    
    @Published var query = ""
    @Published var repositories: [Repository] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private let repositoryService: RepositoryServiceProtocol
    private let debounceInterval: DispatchQueue.SchedulerTimeType.Stride
    private var subscriptions: Set<AnyCancellable> = []
    private var fetchRepositorySubscription: AnyCancellable? = nil
    
    init(repositoryService: RepositoryServiceProtocol, debounceInterval: DispatchQueue.SchedulerTimeType.Stride = .seconds(1)) {
        self.repositoryService = repositoryService
        self.debounceInterval = debounceInterval
        
        setupSubscriptions()
    }
    
    func clear() {
        query = ""
        updateState()
    }
    
    func fetchRepositories() {
        guard query.count > 2 else {
            updateState()
            return
        }
        
        updateState(isLoading: true)
        
        fetchRepositorySubscription = repositoryService
            .fetchRepositories(query: query)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure:
                    self?.updateState(errorMessage: "Error in fetching repositories")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] repositories in
                self?.updateState(repositories: repositories)
            })
    }
    
    // MARK: - Helpers
    
    private func setupSubscriptions() {
        $query
            .removeDuplicates()
            .debounce(for: debounceInterval, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.fetchRepositories()
            }
            .store(in: &subscriptions)
    }
    
    private func updateState(isLoading: Bool = false, errorMessage: String = "", repositories: [Repository] = []) {
        callOnMainThread {
            self.isLoading = isLoading
            self.errorMessage = errorMessage
            self.repositories = repositories
        }
    }
}

extension RepositoryListViewModel {
    func callOnMainThread(_ block: () -> ()) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.sync(execute: block)
        }
    }
}
