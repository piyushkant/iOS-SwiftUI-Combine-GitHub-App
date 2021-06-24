//
//  EmptyView.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import SwiftUI

struct EmptyView: View {

    let message: String

    var body: some View {
        Text(message)
            .font(.callout)
            .multilineTextAlignment(.center)
            .padding()
    }
}
