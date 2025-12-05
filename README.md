# 📱 iOS Playground App - MVVM Architecture Reference
This is a simple task-management app with intentionally over-ingeneered logic in some areas. It serves as a base project for future experiments, which I will add in separate branches (for example, for learning and practicing Clean Architecture).
I created this app as a playground where I can experiment with new features, technologies and architectural patterns that I plan to use in my future projects.

## ⚡ Key Features
- MVVM Architecture with clear separation of concerns
- Dependency Injection Container for service management
- Keychain integration for secure authentication
- Mock data implementation
- Reusable SwiftUI components
- Native components with minimal customization
- Navigation management with Coroutine pattern

## 🎯 Project Overview
<div align="center">
  <table>
    <tr>
      <td><img src="./iOS%20Playground%20App/Resources/screenshots/SignIn.png" width="250" alt="Sign-In Screen"/></td>
      <td><img src="./iOS%20Playground%20App/Resources/screenshots/Tasks.png" width="250" alt="Tasks Screen"/></td>
      <td><img src="./iOS%20Playground%20App/Resources/screenshots/UserProfile.png" width="250" alt="User Profile Screen"/></td>
    </tr>
    <tr>
      <td align="center"><b>🔐 Authentication</b><br/>User login with Keychain storage</td>
      <td align="center"><b>📋 Task List</b><br/>View all tasks with status</td>
      <td align="center"><b>✏️ Task Details</b><br/>Edit or complete tasks</td>
    </tr>
  </table>
</div>


## 📁 Project Structure
```
iOS Playground App (Project Root)
├── Application/
│   ├── DIContainer.swift
│   └── iOS_Playground_AppApp.swift
│   
├── Common/
│   ├── Modifiers/
│   │   └── (Custom view modifiers)
│   │
│   └── Views/
│        └── (Shared reusable views)
│   
├── Core/
│   ├── AuthenticationManager/
│   |   └── (Authentication logic)
│   |
│   ├── Constants/
│   |   └── (App-wide constants)
│   |
│   ├── Coordinator/
│   |   └── (Navigation coordination)
│   |
│   ├── Errors/
│   |    └── (Error definitions)
│   |
│   ├── Network/
│   |   └── (Network layer & API calls)
|   |
│   └── Storage/
│        └── (Data persistence)
│   
├── Model/
│   ├── DTOs/
│   |  └── (Data Transfer Objects)
│   |
│   ├──Entity/
│   |  └── (Core data entities)
│   |
│   └── Types/
│       └── (Custom types & enums)
│   
├── Repositories/
│   ├── Protocols/
│   |   └── (Repository interfaces)
│   |
│   ├── AuthenticationRepositoryImpl.swift
│   ├── TasksRepositoryImpl.swift
│   └── UserRepositoryImpl.swift
│   
├── Resources/
│   └── Assets/
│        └── (Images, colors, assets)
│   
├── Services/
│   ├── Data/
│   |    └── (Data layer services)
│   |
│   ├── Protocols/
│   |   └── (Service interfaces)
│   |
│   ├── AuthenticationServiceImpl.swift
│   ├── TasksServiceImpl.swift
│   └── UserServiceImpl.swift
│   
├── Utilities/
│   ├── Extensions/
│   |   └── (Swift extensions)
│   |
│   ├── Helpers/
│   |   └── Logger.swift
│   └── (Other utilities)
│   
├── ViewModels/
│   ├──Authentication/
│   |   └── (Auth-related ViewModels)
│   |
│   ├── UserProfile/
│   |   └── (User profile ViewModels)
│   |
│   └── UserTasks/
│       └── (Task-related ViewModels)
│   
└── Views/
     ├── Authentication/
     |   └── (Login, signup, auth flows)
     |    
     ├── UserProfile/
     |   └── (Profile screens)
     |   
     ├── UserTasks/
     |    └── (Task list, detail screens)
     |   
     ├── MainNavigationView.swift
     └── RootView.swift
```

## 📂 Folder Organization

## 📐 Architecture Layers

| Layer | Purpose |
|-------|---------|
| **Views** | SwiftUI screens & UI components |
| **ViewModels** | State management & presentation logic |
| **Services** | Business logic & orchestration |
| **Repositories** | Data access & abstraction |
| **Model** | Data structures & domain models |
| **Core** | Infrastructure (Network, Storage, Constants) |
| **Common** | Reusable components & modifiers |
| **Utilities** | Extensions & helper functions |
| **Resources** | Static assets (images, colors, strings) |
| **Application** | App entry point & dependency injection |

## 👮🏻‍♂️ Folder Responsibilities

| # | Folder | Responsibilities |
|---|--------|------------------|
| 1️⃣ | **Application/** | • Initialize the app<br/>• Setup dependency injection<br/>• Configure root view<br/>• Manage environment objects |
| 2️⃣ | **Common/** | • Provide reusable modifiers<br/>• Create shared UI components<br/>• Ensure UI consistency<br/>• Enable component reusability |
| 3️⃣ | **Core/** | • Handle network requests<br/>• Manage data storage<br/>• Define error types<br/>• Store app constants<br/>• Coordinate navigation<br/>• Manage authentication |
| 4️⃣ | **Model/** | • Define domain entities<br/>• Create network DTOs<br/>• Define custom types<br/>• Provide data structures |
| 5️⃣ | **Repositories/** | • Define data access interfaces<br/>• Implement data fetching<br/>• Transform DTOs to entities<br/>• Abstract data sources<br/>• Handle data persistence |
| 6️⃣ | **Resources/** | • Provide images<br/>• Store color definitions<br/>• Manage fonts<br/>• Handle localization |
| 7️⃣ | **Services/** | • Implement business logic<br/>• Orchestrate repositories<br/>• Process data<br/>• Enforce business rules |
| 8️⃣ | **Utilities/** | • Extend Swift types<br/>• Provide helper functions<br/>• Create reusable utilities<br/>• Enable code reuse |
| 9️⃣ | **ViewModels/** | • Manage screen state<br/>• Handle user interactions<br/>• Call services<br/>• Update @Published properties |
| 🔟 | **Views/** | • Display user interface<br/>• Handle user input<br/>• Bind to ViewModels<br/>• Manage navigation |
