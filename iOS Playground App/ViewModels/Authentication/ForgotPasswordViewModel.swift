//
//  ForgotPasswordFormViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation
import Combine

@MainActor
final class ForgotPasswordViewModel: ObservableObject {
    
    private let repository: AuthenticationRepository
    
    @Published var email: String = ""
    
    @Published var isSending: Bool = false
    @Published var errorMessage: String = ""
    
    init(repository: AuthenticationRepository) {
        self.repository = repository
    }
    
    func requestPasswordReset() async throws {
        
        // TODO: Implement input value check
        
        do {
            
            self.isSending = true
            try await repository.requestPasswordReset(email: self.email)
            self.isSending = false
            
        } catch {
            
            self.errorMessage = error.localizedDescription
            self.isSending = false
            
        }
    }
    
}
