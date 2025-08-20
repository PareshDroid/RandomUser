//
//  UserViewModel.swift
//  RandomUser
//
//  Created by Paresh on 17/08/25.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let userService: UserService
    private(set) var hasLoaded = false

    init(userService: UserService = RemoteUserService()) {
            self.userService = userService
    }

    func fetchUsers() {
        //guard is a control flow statement used to early exit a scope if certain conditions aren't met
        
        guard !hasLoaded else { return }
        fetchUsersFromService()
        
        //If hasLoaded is **true**, it means data has already been loaded → so we exit early and skip the network call.

        //If hasLoaded is **false**, it means data hasn’t been loaded yet → continue and call fetchUsersFromNetwork().
    }

    func forceReload() {
        hasLoaded = false
        fetchUsersFromService()
    }

    private func fetchUsersFromService() {
            hasLoaded = true
            isLoading = true
            errorMessage = nil

            userService.fetchUsers { [weak self] result in
                self?.isLoading = false
                switch result {
                case .success(let users):
                    self?.users = users
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
            }
        }
    }
}
