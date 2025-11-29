//
//  EditUserProfileViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 14/11/25.
//

import Foundation
import Combine

extension EditUserProfileView {
        
    @MainActor
    final class ViewModel: ObservableObject {
        
        private let userRepository: UserRepository
        
        private let userInfo: User
        
        // Form States
        @Published var isUpdating: Bool = false
        @Published var isFormSavingDisabled: Bool = true
        
        // Input States
        @Published var userName: String {
            didSet {
                validateValues()
            }
        }
        @Published var userEmail: String {
            didSet {
                validateValues()
            }
        }
        
        // Input Errors
        @Published var emailErrorMessage: String? = nil
        @Published var nameErrorMessage: String? = nil
        
        // Form Errors
        @Published var showErrorAlert: Bool = false
        @Published var errorTitile: String = AppConstants.ERROR_TITLE_PLACEHOLDER
        @Published var errorMessage: String = ""

        init(
            user: User,
            userRepository: UserRepository
        ){
            self.userRepository = userRepository
            
            self.userInfo = user
            
            self.userName = user.name
            
            self.userEmail = user.email
        }
        
        func submit(onSuccess: @escaping (_ updatedUser: User) -> Void ) async {
            
            let isEmailValid = self.validateEmailInput()
            let isNameValid = self.validateUserNameInput()
            
            guard isEmailValid, isNameValid else {
                return
            }
            
            do{
                
                self.isUpdating = true
    
                let updatedUser = User(
                    id: userInfo.id,
                    name: userName,
                    email: userEmail
                )
                
                let updatedUserResponse = try await self.userRepository.updateUser(user: updatedUser)
                
                onSuccess(updatedUserResponse)
                
                self.isUpdating = false
                
            } catch {
                
                self.handleUnexpectedError()
                
                self.isUpdating = false
                
            }
        }
        
        private func validateValues() -> Void {
            
            let name = userName.trim()
            let email = userEmail.trim()
            
            guard !name.isEmpty, !email.isEmpty else {
                self.isFormSavingDisabled = true
                return
            }
            
            let hasChanges = (userInfo.name != userName) || (userInfo.email != userEmail)
            self.isFormSavingDisabled = !hasChanges
             
        }
        
        private func clearInputErrorMessages() {
            
            self.emailErrorMessage = nil
            
            self.nameErrorMessage = nil
        }
        
        func validateEmailInput() -> Bool {
            
            do {
                try Validator.shared.validateEmail(self.userEmail)
                
                return true
                
            } catch let error as ValidationError {
                
                self.emailErrorMessage = error.message
                
                return false
                
            } catch {
                
                self.emailErrorMessage = ValidationError.invalidEmail.message
                
                return false
                
            }
            
        }
        
        func validateUserNameInput() -> Bool {
            
            guard self.userName.trim().isEmpty else {
                return true
            }
            
            self.nameErrorMessage = ValidationError.emptyField(fieldName: "User name").message
            
            return false
        }
        
        func hideErrorAlert() -> Void {
            self.showErrorAlert = false
            self.errorMessage = ""
        }
        
        private func handleUnexpectedError() {
            
            self.errorMessage = "An unexpected error occured. Please try again later."
            
            self.showErrorAlert = true
        }
        
    }
    
}

