```markdown
# 🛍️ Flutter E-Commerce Demo App

A demo mobile application for selling fashion and lifestyle products like shoes, clothes, and more. This project showcases a basic e-commerce app architecture using **Flutter** with **clean architecture** and **Riverpod** for state management.

## 🚀 Features

- 🌠 Splash Screen
- 🏠 Home Screen with tab-based navigation:
  - **Home**: Product offer slider, new arrivals, popular products, and product categories
  - **Orders**: User's order history
  - **Cart**: Recently added products with invoice summary
  - **Favorites**: Wishlisted items
  - **Profile**: User info including name, photo, and phone number
- 📦 Product Details: Complete product info and "Add to Cart" functionality
- 🛒 Cart: Detailed invoice and product list

---

## 🛠️ Tech Stack

- **Flutter SDK**: 3.29.3  
- **Dart**: 3.7.2  
- **IDE**: Android Studio  
- **Architecture**: Clean Architecture  
- **State Management**: `flutter_riverpod`

---

## 📂 Directory Structure

```

lib/
├── core/               # Core utilities (constants, helpers)
│   ├── constants/
│   └── utils/
├── data/               # Data sources and repositories
│   ├── dataSources/
│   │   ├── remote/     # Remote API calls (Dio)
│   │   └── local/      # Local storage (Hive)
│   ├── models/         # Data models
│   └── repositories/   # Data layer repositories
├── domain/             # Business logic
│   ├── providers/      # Riverpod providers
│   └── repositories/   # Interfaces for domain logic
├── l10n/               # Localization files
├── presentation/       # UI layer
│   ├── components/     # Common/custom widgets
│   └── screens/        # All app screens
└── src/                # Generated localization files

````

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_riverpod: ^2.6.1
  flutter_screenutil: ^5.9.3
  google_fonts: ^6.2.1
  intl: any
  dio: ^5.8.0+1
  cached_network_image: ^3.4.0
  infinite_scroll_pagination: ^4.0.0
  shimmer: ^3.0.0
  carousel_slider: ^5.0.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
````

---

## 🧪 Getting Started

1. **Clone the repo:**

   ```bash
   git clone <your-repo-url>
   cd <project-directory>
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Generate localization files:**

   ```bash
   flutter gen-l10n
   ```

4. **Run the app:**

   ```bash
   flutter run
   ```

---

## 📌 Notes

* This is a **demo application**, not intended for production.
* Clean architecture principles are followed to maintain scalability and readability.
* Riverpod ensures scalable state management throughout the app.

## 📄 License

This project is licensed under the MIT License.