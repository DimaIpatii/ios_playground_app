//
//  SignUpView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel: ViewModel
    
    init() {
        
        let authRepository = DIContainer.shared.getInstance(of: AuthenticationRepository.self)
        
        let viewModel = ViewModel(repository: authRepository)
        
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            
            Form{
                
                EmailTextFieldView(
                    email: $viewModel.email,
                    errorMessage: viewModel.emailErrorMessage,
                    onEditingChanged: { isEditing in
                        
                        if !isEditing {
                            let _ = viewModel.validateEmailInput()
                        }
                        
                    }
                )
                
                
                PasswordFieldView(
                    password: $viewModel.password,
                    errorMessage: viewModel.passwordErrorMessage) { isEditing in
                        if !isEditing {
                            let _ = viewModel.validatePasssowrdInput()
                        }
                    }
                
                if let errorMessage = $viewModel.errorMessage.wrappedValue {
                    InputErrorMessageView(errorMessage: errorMessage)
                }
                
                TextButtonView(
                    title: "Sign Up",
                    onPress: {
                        Task {
                            await viewModel.signUp()
                        }
                    }
                )
                
                
            }
            .navigationTitle("Sign Up")
            .alertDialog(
                title: viewModel.errorTitile,
                message: viewModel.errorMessage,
                isPresnted: $viewModel.showErrorAlert,
                confirmAction: viewModel.closeErrorAlert
            )
            
        }
    }
}

#Preview {
    SignUpView(
        
    )
}
