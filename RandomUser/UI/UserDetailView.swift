//
//  UserDetailView.swift
//  RandomUser
//
//  Created by Paresh on 19/08/25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: user.picture.large)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 10)

                Text(user.name.full)
                    .font(.title)
                    .bold()

                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone: \(user.phone)")
                    Text("Cell: \(user.cell)")
                    Text("Location: \(user.location.city), \(user.location.state), \(user.location.country)")
                    Text("Nationality: \(user.nat)")
                    Text("Age: \(user.dob.age)")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle(user.name.first)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(
            gender: "male",
            name: User.Name(title: "Mr", first: "John", last: "Doe"),
            location: User.Location(
                street: User.Location.Street(number: 123, name: "Main Street"),
                city: "New York",
                state: "NY",
                country: "USA",
                coordinates: User.Location.Coordinates(latitude: "40.7128", longitude: "74.0060"),
                timezone: User.Location.TimeZoneInfo(offset: "-5:00", description: "Eastern Time")
            ),
            email: "john.doe@example.com",
            login: User.Login(uuid: "12345", username: "johndoe", password: "password123"),
            dob: User.DateInfo(date: "1985-06-15T10:00:00Z", age: 40),
            registered: User.DateInfo(date: "2010-01-01T12:00:00Z", age: 15),
            phone: "555-1234",
            cell: "555-5678",
            idField: User.APIID(name: "SSN", value: "123-45-6789"),
            picture: User.Picture(
                large: "https://randomuser.me/api/portraits/men/1.jpg",
                medium: "https://randomuser.me/api/portraits/med/men/1.jpg",
                thumbnail: "https://randomuser.me/api/portraits/thumb/men/1.jpg"
            ),
            nat: "US"
        )

        NavigationView {
            UserDetailView(user: mockUser)
        }
    }
}
