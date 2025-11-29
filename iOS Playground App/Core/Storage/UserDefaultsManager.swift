//
//  UserDefaultsManager.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation


internal enum UserDefaultsDataType {
    case bool
    case string
    case int
    case object
    case stringArray
    case dictionary
    case url
    case data
}

protocol UserDefaultsManager {
    
    func create(value: Any, forKey: String)
    
    func read<T>(for key: String, type: UserDefaultsDataType) -> T?
    
    func update(value: Any, forKey: String)
    
    func delet(forKey: String)
    
}

final class UserDefaultsManagerImpl: UserDefaultsManager {
    
    private let storage: UserDefaults = UserDefaults.standard
    
    func create(value: Any, forKey: String) {
        storage.set(value, forKey: forKey)
        storage.synchronize()
    }
    
    
    
    func read<T>(for key: String, type: UserDefaultsDataType) -> T? {
        
        switch type {
        case .bool:
            storage.bool(forKey: key) as? T
        case .string:
            storage.string(forKey: key) as? T
        case .int:
            storage.integer(forKey: key) as? T
        case .object:
            storage.object(forKey: key) as? T
        case .stringArray:
            storage.stringArray(forKey: key) as? T
        case .dictionary:
            storage.dictionary(forKey: key) as? T
        case .url:
            storage.url(forKey: key) as? T
        case .data:
            storage.data(forKey: key) as? T
        }
         
    }
    
    func update(value: Any, forKey: String) {
        storage.setValue(value, forKey: forKey)
        storage.synchronize()
    }
    
    func delet(forKey: String) {
        storage.removeObject(forKey: forKey)
        storage.synchronize()
    }
     
    
    
}
