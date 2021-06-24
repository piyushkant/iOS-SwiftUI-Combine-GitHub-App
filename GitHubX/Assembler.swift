//
//  Assembler.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import Foundation

struct Assembler {
    
    var repositoryListView: RepositoryListView {
        RepositoryListView(viewModel: repositoryListViewModel)
    }
    
    var repositoryListViewModel: RepositoryListViewModel {
        RepositoryListViewModel(repositoryService: repositoryService)
    }
    
    var repositoryService: RepositoryServiceProtocol {
        RepositoryService(api: api)
    }
    
    var api: APIProtocol {
        API.shared
    }
}
