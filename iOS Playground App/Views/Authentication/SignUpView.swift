//
//  SignUpView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel: ViewModel
    @EnvironmentObject private var authenticationCoordinator: AuthenticationNavigationView.AuthenticationCoordinator
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack{
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
                    isLoading: viewModel.isSigningUp,
                    onPress: {
                        Task {
                            await viewModel.signUp(onComplete: {
                                authenticationCoordinator.back()
                            })
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
    AuthenticationNavigationView.AuthenticationCoordinator().view(for: .signUp)
}
