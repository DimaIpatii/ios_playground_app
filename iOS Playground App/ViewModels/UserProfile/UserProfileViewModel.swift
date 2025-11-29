//
//  UserProfileViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 12/11/25.
//

import Foundation
import Combine


extension UserProfileView {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        private let userRepository: UserRepository
        
        private let authenticationRepository: AuthenticationRepository
        
        private let autheticationManager: AuthenticationManager
        
        
        @Published var user: User? = nil
        
        @Published var isInitializing: Bool = false
        
        @Published var isDeleting: Bool = false
        
        var actionsDisabled: Bool {
            return isInitializing || isDeleting
        }
        
        @Published var errorMessage: String = ""

        init(
            userRepository: UserRepository,
            authenticationRepository: AuthenticationRepository,
            autheticationManager: AuthenticationManager
        ) {
            self.userRepository = userRepository
            
            self.authenticationRepository = authenticationRepository
            
            self.autheticationManager = autheticationManager
        }
        
        func initializeUser() async {
            
            do {
                self.isInitializing = true
                
                try await Task.sleep(for: .seconds(3))
                self.user = try await self.userRepository.getUser(id: 1)
                
                self.isInitializing = false
                
            } catch {
                
                self.errorMessage = error.localizedDescription
                
                self.isInitializing = false
                
            }
            
        }
        
        func deleteUser() async {
            
            do {
                isDeleting = true
                
                try await Task.sleep(for: .seconds(3))
                
                try await userRepository.deleteUser(id: Int(user!.id) ?? -1)
                
                self.authenticationRepository.signOut()
                
                self.autheticationManager.removeCredentials()
                
                isDeleting = false
                
            } catch {
                
                errorMessage = error.localizedDescription
                
                isDeleting = false
                
            }
            
        }
        
        func signOut() {
                
            self.authenticationRepository.signOut()
            
            self.autheticationManager.removeCredentials()
            
        }
        
        func setUser(_ user: User) -> Void {
            self.user = user
        }
        
    }
    
}

