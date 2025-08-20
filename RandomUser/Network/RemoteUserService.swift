//
//  RemoteUserService.swift
//  RandomUser
//
//  Created by Paresh on 20/08/25.
//

// RemoteUserService.swift
import Foundation

class RemoteUserService: UserService {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://randomuser.me/api/?results=10") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {// Ensures UI is updated on main thread
                if let error = error {
                    completion(.failure(error))//if network error then set the error message and exit early
                    return
                }

                guard let data = data else {
                    completion(.failure(URLError(.badServerResponse)))// if no data came back (though no error occurred), set a different error message and exit early.
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(RandomUserResponse.self, from: data)//parse data using the defined data model
                    completion(.success(decoded.results))
                } catch {
                    completion(.failure(error))//if decoding fails set the respective error message
                }
            }
        }.resume()
    }
}
