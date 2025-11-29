//
//  DIContainer.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 05/11/25.
//

import Foundation

final class DIContainer {
    
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: Storage for dependencies:
    private var singletons: [String: Any] = [:]
    private var factories: [String: (DIContainer) -> Any] = [:]
    
    
    // MARK: Registration methods:
    private func singletonRegister<T>(_ type: T.Type, instance: T) -> Void {
        let key = String(describing: type)
        singletons[key] = instance
    }
    
    private func lazySingletonRegistry<T>(_ type: T.Type, factory: @escaping (DIContainer) -> T) -> Void {
        let key = String(describing: type)
        
        factories[key] = { [weak self] container in
            
            guard let self = self else {return}
            
            guard let instance = self.singletons[key] as? T else {
                let newInstance = factory(container)
                self.singletons[key] = newInstance
                return newInstance
            }
            
            return instance
        }
    }
    
    // MARK: Resolution methods:
    private func resolve<T>(_ type: T.Type) -> T {
        
        let key = String(describing: type)
        
        // Return singleton instanse
        if let instance = self.singletons[key] as? T {
            return instance
        }
        
        // Return registered factory
        if let factory = self.factories[key] {
            return factory(self) as! T
        }
        
        
        fatalError("Singleton dependency of type \(type) is not registered")
        
    }
    
    func getInstance<T>(of type: T.Type) -> T {
        return self.resolve(type)
    }
    
    
}

// MARK: Dependencies configuration
extension DIContainer {
    
    static func setUpDependencies() -> Void {
        
        let container = DIContainer.shared
        
        // Core services configurations
        self.registerServices(in: container)
        
        // Managers
        self.registerMenagers(in: container)
        
        // Repositories configuration
        self.registerRepositories(in: container)

    }
    
    private static func registerServices(in container: DIContainer) {
        
        // Network Service
        container.lazySingletonRegistry(NetworkManager.self) { _ in
            NetworkManager()
        }
        
        // Authentication Service
        container.lazySingletonRegistry(AuthenticationService.self) { resolver in
            
            let networkManager = resolver.resolve(NetworkManager.self)
            
            return AuthenticationServiceImpl(networkManager: networkManager)
        }
        
        // User Service
        container.lazySingletonRegistry(UserService.self) { resolver in
            
            let networkService = resolver.resolve(NetworkManager.self)
            
            return UserServiceImpl(networkService: networkService)
        }

        // User Tasks Service
        container.lazySingletonRegistry(TasksService.self) { resolver in
            
            let networkService = resolver.resolve(NetworkManager.self)
            
            return TasksServiceImpl(networkService: networkService)
            
        }
        
    }

    private static func registerMenagers(in container: DIContainer) {
        
        container.lazySingletonRegistry(UserDefaultsManager.self) { resolver in
            
            return UserDefaultsManagerImpl()
        }
        
        container.lazySingletonRegistry(KeychainManager.self) { resolver in
            return KeychainManagerImpl()
        }
        
        container.lazySingletonRegistry(AuthenticationManager.self) { resolver in
            
            let keychainManager = resolver.resolve(KeychainManager.self)
            
            return AuthenticationManager(keychainManager: keychainManager)
        }
        
    }
    
    private static func registerRepositories(in container: DIContainer) {
        
        // Authentication Repository
        container.lazySingletonRegistry(AuthenticationRepository.self) { resolver in
            let authenticationService = resolver.resolve(AuthenticationService.self)
            
            return AuthenticationRepositoryImpl(service: authenticationService)
        }
        
        // User Repository
        container.lazySingletonRegistry(UserRepository.self) { resolver in
            let userService = resolver.resolve(UserService.self)
            
            return UserRepositoryImpl(service: userService)
        }
        
        // Tasks Repository
        container.lazySingletonRegistry(TasksRepository.self) { resolver in
            
            let tasksService = resolver.resolve(TasksService.self)
            
            return UserTasksRepositoryImpl(tasksService: tasksService)
        }
    }

}

 
