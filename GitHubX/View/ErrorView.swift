//
//  ErrorView.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import SwiftUI

struct ErrorView: View {

    let message: String

    var body: some View {
        VStack {
            if !message.isEmpty {
                Text(message)
                    .font(.title3)
                    .padding(.top)
                    .foregroundColor(Color(.systemRed))
            }
        }
    }
}
