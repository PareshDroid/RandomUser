//
//  UserService.swift
//  RandomUser
//
//  Created by Paresh on 20/08/25.
//

import Foundation

protocol UserService {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}
