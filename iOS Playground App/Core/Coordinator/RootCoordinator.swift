//
//  RootCoordinator.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 29/11/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class RootCoordinator: ObservableObject {
    
    private let authenticationManager: AuthenticationManager
    
    @Published var isAuthenticated: Bool = false
    
    init(
        authenticationManager: AuthenticationManager
    ) {
        
        self.authenticationManager = authenticationManager
        
        self.checkUserAuthenticated()
        
    }
    
    private func checkUserAuthenticated() -> Void {
        
        self.isAuthenticated = authenticationManager.userId != nil
        
    }
    
    
    func completeAuthentication(with userId: Int) -> Void {
        self.authenticationManager.saveCredentials(userId: userId)
        
        self.checkUserAuthenticated()
    }
    
    func startAuthentication() -> Void {
        
        self.authenticationManager.removeCredentials()
        
        self.checkUserAuthenticated()
        
    }
    
    
}
