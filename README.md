# Gutenberg Book Listing App

A practical Flutter application for browsing and discovering books, inspired by Project Gutenberg. This project demonstrates clean architecture, state management, and responsive UI for both mobile and web platforms.

---

## 🚀 Overview

This app allows users to:

- Browse a catalog of books with cover images, titles, and authors
- Filter books by genre
- Search for books
- View book details and open them in the browser
- Responsive design for mobile and web (Chrome supported)

This repository is part of a practical coding task and showcases best practices in Flutter development.

---

## ✨ Features

- Clean architecture (data, domain, presentation layers)
- Bloc/Cubit state management
- Cached network images for image loading
- Error handling and loading indicators
- Modern, responsive UI

---

## 🛠️ Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/gutenberg.git
   cd gutenberg
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the app:**
   - For mobile:
     ```bash
     flutter run
     ```
   - For web (Chrome):
     ```bash
     flutter run -d chrome
     ```

---

## 📁 Folder Structure

```
lib/
  core/         # Core utilities, theme, error handling
  features/
    books/      # Book feature (data, domain, presentation)
  main.dart     # App entry point
assets/
  svg/          # SVG assets for genres and icons
```

