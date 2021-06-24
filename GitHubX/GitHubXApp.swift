//
//  GitHubXApp.swift
//  GitHubX
//
//  Created by Piyush Kant on 2021/06/12.
//

import SwiftUI

@main
struct GitHubXApp: App {
    var body: some Scene {
        WindowGroup {
            Assembler()
                .repositoryListView
                .foregroundColor(.primary)
                .accentColor(.primary)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
