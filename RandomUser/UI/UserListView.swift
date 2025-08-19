//
//  UserListView.swift
//  RandomUser
//
//  Created by Paresh on 17/08/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                        Button("Retry") {
                            viewModel.fetchUsers()
                        }
                    }
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            HStack {
                                AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())

                                VStack(alignment: .leading) {
                                    Text(user.name.full).bold()
                                    Text(user.email).font(.subheadline).foregroundColor(.gray)
                                    Text("\(user.location.city), \(user.location.country)").font(.caption)
                                }
                            }
                        }
                    }

                }
            }
            .refreshable {
                viewModel.forceReload()
            }
            .navigationTitle("Random Users")
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}


struct UserListView_Previews: PreviewProvider {
    class MockUserViewModel: UserViewModel {
        override init() {
            super.init()
            self.users = [
                User(
                    gender: "female",
                    name: User.Name(title: "Ms", first: "Jane", last: "Smith"),
                    location: User.Location(
                        street: User.Location.Street(number: 456, name: "Broadway"),
                        city: "Los Angeles",
                        state: "CA",
                        country: "USA",
                        coordinates: User.Location.Coordinates(latitude: "34.0522", longitude: "118.2437"),
                        timezone: User.Location.TimeZoneInfo(offset: "-8:00", description: "Pacific Time")
                    ),
                    email: "jane.smith@example.com",
                    login: User.Login(uuid: "67890", username: "janesmith", password: "securepass"),
                    dob: User.DateInfo(date: "1990-05-20T10:00:00Z", age: 35),
                    registered: User.DateInfo(date: "2015-02-15T12:00:00Z", age: 10),
                    phone: "555-9876",
                    cell: "555-6543",
                    idField: User.APIID(name: "SSN", value: "987-65-4321"),
                    picture: User.Picture(
                        large: "https://randomuser.me/api/portraits/women/1.jpg",
                        medium: "https://randomuser.me/api/portraits/med/women/1.jpg",
                        thumbnail: "https://randomuser.me/api/portraits/thumb/women/1.jpg"
                    ),
                    nat: "US"
                )
            ]
        }
    }

    struct PreviewWrapper: View {
        @StateObject var viewModel = MockUserViewModel()

        var body: some View {
            UserListView()
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
