//
//  User.swift
//  RandomUser
//
//  Created by Paresh on 17/08/25.
//

import Foundation

struct RandomUserResponse: Codable {
    let results: [User]
}

// MARK: - User
struct User: Codable, Identifiable {
    var id: String { login.uuid } // Use login.uuid as unique identifier (more reliable than id.value)

    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: DateInfo
    let registered: DateInfo
    let phone, cell: String
    let idField: APIID
    let picture: Picture
    let nat: String

    enum CodingKeys: String, CodingKey {
        case gender, name, location, email, login, dob, registered, phone, cell, picture, nat
        case idField = "id"
    }

    struct APIID: Codable {
        let name: String
        let value: String?
    }

    struct Name: Codable {
        let title, first, last: String

        var full: String {
            "\(title) \(first) \(last)"
        }
    }

    struct Location: Codable {
        let street: Street
        let city, state, country: String
        let coordinates: Coordinates
        let timezone: TimeZoneInfo

        struct Street: Codable {
            let number: Int
            let name: String
        }

        struct Coordinates: Codable {
            let latitude, longitude: String
        }

        struct TimeZoneInfo: Codable {
            let offset, description: String
        }
    }

    struct Login: Codable {
        let uuid: String
        let username, password: String
    }

    struct DateInfo: Codable {
        let date: String
        let age: Int
    }

    struct Picture: Codable {
        let large, medium, thumbnail: String
    }
}
