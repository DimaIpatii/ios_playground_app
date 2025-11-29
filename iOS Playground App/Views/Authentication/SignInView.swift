//
//  SignInView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var viewModel: ViewModel
    
    @State var isForgotPasswordFormPresented: Bool = false
    
    @State var isSignUpFormPresented: Bool = false
    
    init() {
        
        let authenticationRepository = DIContainer.shared.getInstance(of: AuthenticationRepository.self)
        
        let authenticationManager = DIContainer.shared.getInstance(of: AuthenticationManager.self)
        
        let viewModel = ViewModel(
            repository: authenticationRepository,
            authenticationManager: authenticationManager
        )
        
        self._viewModel = StateObject(wrappedValue: viewModel)
    
    }
    var body: some View {
        NavigationStack{
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
                                isForgotPasswordFormPresented = true
                            }
                        )
                        
                    }
                    
                }
                .sheet(isPresented: $isForgotPasswordFormPresented) {
                    PasswordResetView()
                }
                
            }
            .navigationTitle("Sign In")
            
            VStack(spacing: 20){
                
                PrimaryButtonView(
                    title: "Sign In",
                    isLoading: viewModel.isSiginingIn,
                    onPress: {
                        Task {
                            await viewModel.signIn()
                        }
                    }
                )
                .frame(maxWidth: .infinity)
                
                TextButtonView(
                    title: "Sign Up",
                    isDisabled: viewModel.isSiginingIn,
                    onPress: {
                        self.isSignUpFormPresented = true
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
        .sheet(
            isPresented: $isSignUpFormPresented
        ) {
            SignUpView()
        }
        
    }
}

#Preview {
    SignInView()
}
