# 📰 Articles App (Clean Architecture with Flutter + BLoC)

This project is a Flutter application built using **Clean Architecture** principles and **BLoC state management**.  
It allows users to **fetch articles**, **like/dislike them**, and **view liked/disliked articles**.

---

## 📂 Project Structure

We follow **Clean Architecture** with 3 main layers:  

<img width="571" height="399" alt="{6525507E-5353-4A67-B4BE-08A5A086A33C}" src="https://github.com/user-attachments/assets/6197ee22-7dc9-4fb7-818e-6e7f181199ff" />

## 🏗 Layers Explained

### 1️⃣ Data Layer – *“How to get data”*
- **RemoteDataSource** → fetches articles from API.  
- **LocalDataSource** → stores liked/disliked articles in local storage (e.g., SharedPreferences).  
- **Models** → classes that map backend response (JSON) into Dart objects.  
- **Repository Implementation** → connects Data layer with Domain layer.  

---

### 2️⃣ Domain Layer – *“What needs to be done”*
- **Entities** → core objects of the app (e.g., `Article`).  
- **Repository (abstract)** → defines what operations are available (e.g., `getArticles`, `likeArticle`).  
- **UseCases** → represent single actions (e.g., `GetArticlesUseCase`, `LikeArticleUseCase`).  

👉 The Domain layer doesn’t know **how** things are done, it only defines **what** needs to happen.  

---

### 3️⃣ Presentation Layer – *“How things look”*
- **Bloc (Business Logic Component)**  
  - **Events** → user actions (e.g., `LoadArticles`, `LikeArticle`).  
  - **States** → app states (`Loading`, `Loaded`, `Error`).  
  - **Bloc** → takes Events → runs UseCases → emits States.  
- **Pages** → Flutter screens (HomePage, LikedPage, DislikedPage).  
- **Widgets** → reusable UI components (e.g., `ArticleCard`).  

---

## ⚙️ Dependency Injection

We use **get_it** as Service Locator.  

- `registerLazySingleton` → creates instance only when first needed.  
- `registerSingleton` → creates instance immediately at startup.  
- `registerFactory` → creates a new instance every time (used for Blocs).  

📌 Example:  
```dart
sl.registerLazySingleton(() => http.Client()); // created only when used
sl.registerFactory(() => HomeBloc(getArticles: sl())); // new instance every time
```
🚀 Features

- Fetch latest articles from API.
- Swipe right 👍 to like an article.
- Swipe left 👎 to dislike an article.
- View Liked Articles and Disliked Articles on separate pages.
- Offline storage for liked/disliked articles.

🛠 Tech Stack

- **Flutter** – UI framework.
- **BLoC** – State management.
- **Clean Architecture** – Project structure.
- **GetIt** – Dependency Injection.
- **SharedPreferences** – Local storage.
- **HTTP** – API calls.

📸 Screens (Example)

- **Home Screen** → Swipe articles (like/dislike).
- **Liked Screen** → View liked articles.
- **Disliked Screen** → View disliked articles.
