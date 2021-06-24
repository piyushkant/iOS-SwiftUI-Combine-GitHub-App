//
//  ListCardView.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import SwiftUI

struct ListCardView: View {
    let repository: Repository

    var body: some View {
        HStack {
            Text(repository.name)
                .font(.callout)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.body)
                .padding(.trailing, 5)
        }
        .padding(10)
        .background(Color(.systemFill))
        .cornerRadius(10)
    }
}
