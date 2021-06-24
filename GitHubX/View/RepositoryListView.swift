//
//  RepositoryListView.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: RepositoryListViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                Group {
                    setupSearchBar()
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    setupContent()
                        .padding(.horizontal)
                }
            }
            .navigationBarTitle("Search repository")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
    
    // MARK: - Subviews
    
    func setupSearchBar() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("repository name", text: $viewModel.query)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            Button(action: {
                viewModel.clear()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .opacity(viewModel.query == "" ? 0 : 1)
            }
        }
        .padding()
        .background(Color(.systemFill))
        .cornerRadius(10)
    }
    
    func setupContent() -> some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
                    .padding(.top, 40)
            } else {
                ErrorView(message: viewModel.errorMessage)
                
                if viewModel.repositories.count > 0 {
                    setupList()
                } else {
                    EmptyView(message: "Search GitHub repositories by typing in searchbar.")
                }
            }
        }
    }
    
    func setupList() -> some View {
        LazyVStack {
            ForEach(viewModel.repositories) { repository in
                NavigationLink(
                    destination: RepositoryDetailView(repository: repository),
                    label: {
                        ListCardView(repository: repository)
                            .padding(.top, 10)
                    })
            }
        }
    }
}

