//
//  ForgotPasswordFormViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation
import Combine


extension PasswordResetView {
        
    @MainActor
    final class ViewModel: ObservableObject {
        
        private let repository: AuthenticationRepository
        
        // Form States
        @Published var isSending: Bool = false
        var disableSending: Bool {
            isSending || email.isEmpty
        }
        
        // Input States
        @Published var email: String = ""
        
        // Input Errors
        @Published var emailErrorMessage: String? = nil
        
        // Form Errors
        @Published var showAlerError: Bool = false
        @Published var errorTitle: String = AppConstants.ERROR_TITLE_PLACEHOLDER
        @Published var errorMessage: String? = nil
        
        
        init(repository: AuthenticationRepository) {
            self.repository = repository
        }
        
        func requestPasswordReset(onComplete: @escaping () -> Void) async {
            
            let isEmailValid = self.validateEmailInput()
            
            guard isEmailValid else {
                return
            }
            
            do {

                self.isSending = true
                
                try await repository.requestPasswordReset(email: self.email)
                
                self.isSending = false
                
            } catch {
                
                self.handleUnexpectedError()
                
                self.isSending = false
                
            }
        }
        
        func closeErrorAlert() -> Void {
            
            self.clearFormErrors()
            
        }
        
        private func clearEmailError() -> Void {
            
            self.emailErrorMessage = nil
            
        }
        
        func validateEmailInput() -> Bool {
            
            do {
                
                try Validator.shared.validateEmail(self.email)
                
                return true
                
            } catch let error as ValidationError {
                
                self.emailErrorMessage = error.message

                return false
                
            } catch {
                
                self.emailErrorMessage = ValidationError.invalidEmail.message
                
                return false
                
            }
            
        }
        
        private func clearFormErrors() -> Void {
            
            self.showAlerError = false
            
            self.errorMessage = nil
            
        }
        
        private func handleUnexpectedError() -> Void {
            
            self.showAlerError = true
            
            self.errorMessage = "An unexpected error has occurred. Please try again later."
            
        }
        
    }

    
}
