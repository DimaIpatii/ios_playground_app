//
//  PasswordResetView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import SwiftUI

struct PasswordResetView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel: ViewModel
    
    init() {
        let authenticationRepository = DIContainer.shared.getInstance(of: AuthenticationRepository.self)
        
        let viewModel = ViewModel(repository: authenticationRepository)
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack{
            
            Form {
                
                Text("Provide the email associated with your account. We will send you a link to reset your password.")
                    .multilineTextAlignment(.center)
                
                
                EmailTextFieldView(
                    email: $viewModel.email,
                    errorMessage: viewModel.emailErrorMessage) { isEditing in
                        if !isEditing {
                            let _ = viewModel.validateEmailInput()
                        }
                    }
            }
            .navigationTitle("Forgot Password")
            .navigationBarTitleDisplayMode(.inline)
            .alertDialog(
                title: viewModel.errorTitle,
                message: viewModel.errorMessage,
                isPresnted: $viewModel.showAlerError,
                confirmAction: viewModel.closeErrorAlert
            )
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    
                    IconButtonView(
                        icon: "paperplane",
                        isDisabled: viewModel.disableSending,
                        isLoading: viewModel.isSending,
                        onPress: {
                            Task {
                                await viewModel.requestPasswordReset {
                                    dismiss()
                                }   
                            }
                        }
                    )
                    
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    TextButtonView(
                        title: "Cancel",
                        isDisabled: viewModel.isSending,
                        onPress: {
                            dismiss()
                        }
                    )
                   
                }
            }
        }
    }
}

#Preview {
    PasswordResetView(
        
    )
}
