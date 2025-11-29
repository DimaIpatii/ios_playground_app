//
//  SignUpFormViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation
import Combine

@MainActor
final class SignUpViewModel: ObservableObject {
    
    private let repository: AuthenticationRepository
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    
    @Published var isSigningUp: Bool = false
    @Published var errorMessage: String = ""
    
    
    init(repository: AuthenticationRepository) {
        self.repository = repository
    }
    
    func signUp() async {
        
        // TODO: Implement input values check
        
        do {
            
            self.isSigningUp = true
            try await repository.signUp(email: self.email, password: self.password, name: self.name)
            self.isSigningUp = false
            
        } catch {
            self.errorMessage = error.localizedDescription
            self.isSigningUp = false
        }
        
    }
    
    
}
