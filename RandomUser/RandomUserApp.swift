//
//  RandomUserApp.swift
//  RandomUser
//
//  Created by Paresh on 17/08/25.
//

import SwiftUI

@main
struct RandomUserApp: App {
    var body: some Scene {
        WindowGroup {
            let userService = RemoteUserService() // real network service
            let viewModel = UserViewModel(userService: userService)
            UserListView(viewModel: viewModel)
        }
    }
}
