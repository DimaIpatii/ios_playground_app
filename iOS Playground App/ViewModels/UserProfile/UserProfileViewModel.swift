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

        @Published var user: User? = nil
        
        @Published var isInitializing: Bool = false
        
        @Published var isDeleting: Bool = false
        
        var actionsDisabled: Bool {
            return isInitializing || isDeleting
        }
        
        @Published var errorMessage: String = ""

        init(
            userRepository: UserRepository,
            authenticationRepository: AuthenticationRepository
        ) {
            self.userRepository = userRepository
            
            self.authenticationRepository = authenticationRepository

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
        
        func deleteUser(onSuccess: @escaping () -> Void ) {
            
            Task {
                do {
                    isDeleting = true
                    
                    try await Task.sleep(for: .seconds(3))
                    
                    try await userRepository.deleteUser(id: Int(user!.id) ?? -1)
                    
                    self.authenticationRepository.signOut()
                    
                    onSuccess()
                    
                    isDeleting = false
                    
                } catch {
                    
                    errorMessage = error.localizedDescription
                    
                    isDeleting = false
                    
                }
            }
            
        }
        
        func signOut(onComplete: @escaping () -> Void) -> Void {
                
            self.authenticationRepository.signOut()
            onComplete()
            
        }
        
        func setUser(_ user: User) -> Void {
            self.user = user
        }
        
    }
    
}

