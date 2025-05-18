# 💸 Budget Feature Example for iOS

[![Swift](https://img.shields.io/badge/Swift-6.0-FA7343.svg?style=flat&logo=swift)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg?style=flat&logo=apple)](https://developer.apple.com/ios/)
[![GitHub tag](https://img.shields.io/github/v/tag/nothing-to-add/budget-feature-example-for-ios?style=flat&logo=github)](https://github.com/nothing-to-add/budget-feature-example-for-ios/tags)
[![GitHub stars](https://img.shields.io/github/stars/nothing-to-add/budget-feature-example-for-ios?style=flat&logo=github)](https://github.com/nothing-to-add/budget-feature-example-for-ios/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/nothing-to-add/budget-feature-example-for-ios?style=flat&logo=github)](https://github.com/nothing-to-add/budget-feature-example-for-ios/issues)
[![GitHub contributors](https://img.shields.io/github/contributors/nothing-to-add/budget-feature-example-for-ios?style=flat&logo=github)](https://github.com/nothing-to-add/budget-feature-example-for-ios/graphs/contributors)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/nothing-to-add/budget-feature-example-for-ios?style=flat&logo=github)](https://github.com/nothing-to-add/budget-feature-example-for-ios/commits/main)
[![GitHub top language](https://img.shields.io/github/languages/top/nothing-to-add/budget-feature-example-for-ios?style=flat&logo=swift)](https://github.com/nothing-to-add/budget-feature-example-for-ios)
[![License](https://img.shields.io/github/license/nothing-to-add/budget-feature-example-for-ios?style=flat)](LICENSE.md)

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

```
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
```

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

