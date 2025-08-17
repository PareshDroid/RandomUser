# 👤 RandomUser MVVM SwiftUI App

A SwiftUI app that fetches and displays user profiles from the [RandomUser API](https://randomuser.me) using the **MVVM architecture**.

---

## 📦 Features

- ✅ Fetches users from `https://randomuser.me/api`
- ✅ Displays profile picture, name, email, and location
- ✅ SwiftUI `List` with dynamic user rendering
- ✅ MVVM pattern
- ✅ Handles inconsistent API data:
  - `postcode` can be string or int
  - `id.value` can be null

---

## 🧱 Architecture

This project uses the **Model-View-ViewModel (MVVM)** pattern:

📁 Model/
└── User.swift

📁 ViewModel/
└── UserViewModel.swift

📁 UI/
└── UserListView.swift


## 🚀 How It Works

1. On app launch, the `UserViewModel` fetches random user data from the API.
2. JSON is decoded into `User` model objects.
3. The `UserListView` subscribes to the `@Published` users and renders a list.

🛠️ Requirements

1. iOS 15+
2. Swift 5.5+
3. Xcode 13+


+

💡 Future Improvements

1. Add detail view for each user
2. Caching or local storage (e.g. SwiftData)
3. Paging / infinite scroll
4. Search or filtering

