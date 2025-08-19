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
        guard !hasLoaded else { return }
        fetchUsersFromNetwork()
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
            DispatchQueue.main.async {
                self?.isLoading = false

                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self?.errorMessage = "No data"
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(RandomUserResponse.self, from: data)
                    self?.users = decoded.results
                } catch {
                    self?.errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
