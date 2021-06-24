//
//  RepositoryDetailView.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let profileURL = URL(string: repository.url) {
                    Link("Visit repository in browser", destination: profileURL)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.top)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding()
        .navigationBarTitle(repository.name)
    }
}
