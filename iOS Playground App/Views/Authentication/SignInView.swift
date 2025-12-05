//
//  SignInView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject private var rootCoordinator: RootCoordinator
    @EnvironmentObject private var authenticationCoordinator: AuthenticationNavigationView.AuthenticationCoordinator
    
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    
    }
    var body: some View {
        VStack{
            Form{
                
                Section {
                    EmailTextFieldView(
                        email: $viewModel.email,
                        errorMessage: viewModel.emailErrorMessage
                    )
                    
                    VStack(spacing: 20){
                        PasswordFieldView(
                            password: $viewModel.password
                        )
                        
                        if let errorMessage = viewModel.authenticationError {
                            InputErrorMessageView(errorMessage: errorMessage)
                        }
                        
                        TextButtonView(
                            title: "Forgot password?",
                            isDisabled: viewModel.isSiginingIn,
                            onPress: {
                                authenticationCoordinator.openSheet(for: .forgetPassword)
                            }
                        )
                        
                    }
                    
                }
                
                
            }
            .navigationTitle("Sign In")
            
            VStack(spacing: 20){
                
                PrimaryButtonView(
                    title: "Sign In",
                    isLoading: viewModel.isSiginingIn,
                    onPress: {
                        viewModel.signIn { userId in
                            rootCoordinator.completeAuthentication(with: userId)
                        }
                    }
                )
                .frame(maxWidth: .infinity)
                
                TextButtonView(
                    title: "Sign Up",
                    isDisabled: viewModel.isSiginingIn,
                    onPress: {
                        authenticationCoordinator.navigate(to: .signUp)
                    }
                )
                .frame(maxWidth: .infinity)
                
            }
            .padding()
        }
        .alertDialog(
            title: viewModel.errorTitle,
            message: viewModel.errorMessage,
            isPresnted: $viewModel.showErrorAlert,
            confirmAction: viewModel.closeErrorAlert
        )
        
        
    }
}

#Preview {
    AuthenticationNavigationView.AuthenticationCoordinator().view(for: .signIn)
}
