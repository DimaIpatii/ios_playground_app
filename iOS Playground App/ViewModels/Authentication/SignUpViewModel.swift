//
//  SignUpFormViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation
import Combine

extension SignUpView {

    @MainActor
    final class ViewModel: ObservableObject {
        
        private let repository: AuthenticationRepository
        
        // Form State
        @Published var isSigningUp: Bool = false
        
        // Input Values
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var name: String = ""
        
        // Input Errors
        @Published var emailErrorMessage: String? = nil
        @Published var passwordErrorMessage: String? = nil
        
        // Form Errors
        @Published var showErrorAlert: Bool = false
        @Published var errorTitile: String = "Error"
        @Published var errorMessage: String? = nil
        
        init(repository: AuthenticationRepository) {
            self.repository = repository
        }
        
        func signUp() async {

            let isEmailValid = self.validateEmailInput()
            
            let isPasswordValid = self.validatePasssowrdInput()
            
            guard isEmailValid, isPasswordValid else {
                return
            }
            
            do {
                
                self.isSigningUp = true
                
                try await repository.signUp(email: self.email, password: self.password, name: self.name)
                
                self.isSigningUp = false
                
            } catch let error as AppError {
                
                handleError(error)
                
            } catch {
                
                self.handleUnexpectedError()
                
                self.isSigningUp = false
                
            }
            
        }
        
        func closeErrorAlert() -> Void {
            
            self.clearError()
            
        }
        
        private func clearInputValidationErrors() -> Void {
            
            self.emailErrorMessage = nil
            
            self.passwordErrorMessage = nil
            
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
        
        func validatePasssowrdInput() -> Bool {
            
            do {
                
                try Validator.shared.validatePassword(password)
                
                return true
                
            } catch let error as ValidationError {
                
                self.passwordErrorMessage = error.message

                return false
                
            } catch {
                
                self.passwordErrorMessage = ValidationError.invalidPasswordFormat.message

                return false
                
            }
        }
        
        private func clearError() {
            
            self.showErrorAlert = false
            
            self.errorTitile = ""
            
            self.errorMessage = nil
            
        }
        
        private func handleError(_ error: AppError) -> Void {
            
            self.errorTitile = error.title
            
            self.errorMessage = error.message
            
            self.showErrorAlert = true
            
        }
        
        private func handleUnexpectedError() -> Void {
            
            self.errorTitile = "Error"
            
            self.errorMessage = "Something went wrong. Please try again."
            
            self.showErrorAlert = true
            
        }
        
    }

}

