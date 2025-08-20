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
    
    private(set) var hasLoaded = false

    func fetchUsers() {
        //guard is a control flow statement used to early exit a scope if certain conditions aren't met
        
        guard !hasLoaded else { return }
        fetchUsersFromNetwork()
        
        //If hasLoaded is **true**, it means data has already been loaded → so we exit early and skip the network call.

        //If hasLoaded is **false**, it means data hasn’t been loaded yet → continue and call fetchUsersFromNetwork().
    }

    func forceReload() {
        fetchUsersFromNetwork()
    }

    private func fetchUsersFromNetwork() {
        hasLoaded = true
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://randomuser.me/api/?results=10") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async { // Ensures UI is updated on main thread
                self?.isLoading = false //loading has finished so marking the loading as false

                if let error = error {
                    self?.errorMessage = error.localizedDescription //if network error then set the error message and exit early
                    return
                }

                guard let data = data else {
                    self?.errorMessage = "No data" // if no data came back (though no error occurred), set a different error message and exit early.
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(RandomUserResponse.self, from: data) //parse data using the defined data model
                    self?.users = decoded.results
                } catch {
                    self?.errorMessage = "Decoding error: \(error.localizedDescription)" //if decoding fails set the respective error message
                }
            }
        }.resume()
    }
}
