//
//  KeychainManager.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation
import Security


internal enum KeychainKey: String {
    case userId
    case password
    case authToken
}


protocol KeychainManager {
    func save(_ value: String, for key: KeychainKey) -> Void
    
    func read(for key: KeychainKey) -> String?
    
    func delete(for key: KeychainKey) -> Void
}


final class KeychainManagerImpl: KeychainManager {

    func save(_ value: String, for key: KeychainKey) -> Void {

        let data = value.data(using: .utf8)!
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecValueData: data
        ] as CFDictionary
        
        // Delete previousely saved item
        SecItemDelete(query)
        
        // Save item
        SecItemAdd(query, nil)
    
    }
    
    func read(for key: KeychainKey) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query, &item)
        
        guard status == errSecSuccess, let data = item as? Data else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func delete(for key: KeychainKey) -> Void {
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ] as CFDictionary
        
        SecItemDelete(query)
        
    }
    
}
