//
//  SignInFormViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation
import Combine


extension SignInView {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        private let authenticationManager: AuthenticationManager
        private let repository: AuthenticationRepository
        
        // Form States
        @Published var isSiginingIn: Bool = false
        
        // Input Values
        @Published var email: String = ""
        @Published var password: String = ""
        
        // Input Errors
        @Published var emailErrorMessage: String? = nil
        @Published var authenticationError: String? = nil
        
        // Form Errors
        @Published var showErrorAlert: Bool = false
        @Published var errorTitle: String = AppConstants.ERROR_TITLE_PLACEHOLDER
        @Published var errorMessage: String? = nil

        init(
            repository: AuthenticationRepository,
            authenticationManager: AuthenticationManager
        ) {
            self.repository = repository
            self.authenticationManager = authenticationManager
        }
        
        func signIn() async {
                    
            let isEmailValid = self.validateEmailInput()
            
            let isPasswordValid = self.validatePasswordInput()
            
            guard isEmailValid, isPasswordValid else {
                return
            }
            
            do {

                self.isSiginingIn = true
                
                let userId = try await self.repository.signIn(email: self.email, password: self.password)
                
                self.isSiginingIn = false
                
                self.authenticationManager.saveCredentials(userId: userId)
                
            }  catch {
                
                self.handleUnexpectedError()
                
                self.isSiginingIn = false
                
            }
        }
        
        func closeErrorAlert() -> Void {
            
            self.clearErrorMessage()
            
        }
        
        private func clearInputErrorMessages() {
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
                
                self.authenticationError = AuthenticationError.invalidCredentials.message
                
                return false
                
            }
            
        }
        
        func validatePasswordInput() -> Bool {
            do {
                
                try Validator.shared.validatePassword(self.password)
                
                return true
                
            } catch {
             
                self.authenticationError = AuthenticationError.invalidCredentials.message

                return false
                
            }
        }
        
        private func clearErrorMessage() -> Void {
            
            self.showErrorAlert = false
            
            self.errorMessage = nil
            
        }
        
        private func handleUnexpectedError() -> Void {

            self.errorMessage = "Something went wrong. Please try again."
            
            self.showErrorAlert = true
            
        }
        
    }
    

}
