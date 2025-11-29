//
//  AuthenticationManager.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation
import Combine

final class AuthenticationManager: ObservableObject {

    private let keychainManager: KeychainManager
    
    @Published var isAuthenticated: Bool = false
    @Published var userId: UserId? = nil {
        didSet {
            self.isAuthenticated = self.userId != nil
        }
    }
    
    init(
        keychainManager: KeychainManager
    ) {
        self.keychainManager = keychainManager
        
        self.fetchUserId()
    }
    
    func fetchUserId() {
        
        let userId = self.keychainManager.read(for: .userId)
        
        self.userId = userId
        
    }
    
    func saveCredentials(userId: Int) {
        
        self.keychainManager.save("\(userId)", for: .userId)
        
        self.fetchUserId()
        
    }
    
    func removeCredentials() {
        
        self.keychainManager.delete(for: .userId)
        
        self.fetchUserId()
    }
    
}
