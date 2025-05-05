# 💸 Budget Feature Example for iOS

This repository demonstrates a modular **Budget Feature** implemented as a **Swift Package**, built using **SwiftUI**, following the **MVVM architecture** with a **Router navigation pattern** and **mocked data** instead of live HTTPS requests.

> ✅ Designed to be clean, testable, and easy to extend or integrate into a larger app.

---

## 🧰 Features

- 📦 Swift Package ready for integration
- 🧱 Modular architecture with clearly separated concerns
- 💡 SwiftUI-based UI components
- 🧭 Custom Router pattern for navigation
- 🧪 Unit tested ViewModels
- 🚫 No real networking – mocked data used for easier testing and demonstration
- ✅ Supports iOS **17+**
- ⚙️ Written in **Swift 6.0**

---

## 🗂 Project Structure

'''
BudgetFeaturePackage/
│
├── Elements/ # Reusable UI components (e.g. ProgressBarView, custom styles)
├── Enums/ # Budget-related enums (e.g. BudgetCategories)
├── Extensions/ # Swift extensions (Color, Double, LinearGradient, etc.)
├── Models/ # Data models for the budget feature
├── Router/ # Navigation management (Router classes and structs)
├── Services/ # Protocols, mock services, and placeholder for HTTPS
├── Utilities/ # Helpers (e.g. DateManager, String formatters)
├── ViewModels/ # Logic and data binding for each view
├── Views/ # SwiftUI view files
└── Tests/ # Unit tests for ViewModels
'''

---

## 📦 Installation

### Swift Package Manager

1. Open your project in Xcode.
2. Go to `File > Add Packages`.
3. Enter the repository URL:
https://github.com/nothing-to-add/budget-feature-example-for-ios

4. Choose the version or branch you want, and add the package to your target.

---

## 🧪 Testing

- Run tests via Xcode's Test navigator or by pressing `Cmd + U`.
- All ViewModel logic is covered with unit tests located in the `Tests` directory.

---

## 🧭 Navigation

Navigation is managed using a **custom Router pattern**, which separates navigation logic from views and view models, improving modularity and testability.

---

## 📊 Data Handling

- No real HTTPS or API requests are made.
- All data is mocked to simulate realistic scenarios for testing and development.
- Placeholder services are provided for future integration with live APIs.

---

## 📌 Requirements

- iOS 17 or later
- Swift 6.0
- Xcode 15+

---

## 📖 License

This project is open source and available under the [MIT License](./LICENSE).

---

## 🙌 Contribution

Contributions and feedback are welcome. Please open issues or submit pull requests for suggestions and improvements.

