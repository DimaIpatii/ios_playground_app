//
//  SignInFormViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation
import Combine

@MainActor
final class SignInViewModel: ObservableObject {
    
    private let repository: AuthenticationRepository
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isSiginingIn: Bool = false
    @Published var errorMessage: String = ""
    
    init(repository: AuthenticationRepository) {
        self.repository = repository
    }
    
    func signIn() async {
        
        // TODO: Email and Password Check
        do {
            
            self.isSiginingIn = true
            try await self.repository.signIn(email: self.email, password: self.password)
            self.isSiginingIn = false
            
        } catch {
            
            self.errorMessage = error.localizedDescription
            
            self.isSiginingIn = false
            
        }
    }
    
}
