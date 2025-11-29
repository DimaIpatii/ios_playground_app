//
//  EditUserProfileView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 14/11/25.
//

import SwiftUI


typealias OnEditindCompleteCallback = (_ updatedUser: User) -> Void

struct EditUserProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel: ViewModel
    let onEditingComplete: OnEditindCompleteCallback
    
    init(
        user: User,
        onEditingComplete: @escaping OnEditindCompleteCallback
    ) {
        
        let userRepository = DIContainer.shared.getInstance(of: UserRepository.self)
        
        let viewModel = ViewModel(user: user, userRepository: userRepository)
        
        self._viewModel = StateObject(wrappedValue: viewModel)
        
        self.onEditingComplete = onEditingComplete
        
    }
    
    var body: some View {
        NavigationStack {
            
            Form {
                
                TextFieldView(
                    label: "Name",
                    text: $viewModel.userName,
                    errorMessage: viewModel.nameErrorMessage
                ) { isEditing in
                        if !isEditing {
                            let _ = viewModel.validateUserNameInput()
                        }
                    }
                
                EmailTextFieldView(
                    email: $viewModel.userEmail,
                    errorMessage: viewModel.emailErrorMessage) { isEditing in
                        if !isEditing {
                            let _ = viewModel.validateEmailInput()
                        }
                    }
                
            }
            .navigationBarTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .alertDialog(
                title: viewModel.errorTitile,
                message: viewModel.errorMessage,
                isPresnted: $viewModel.showErrorAlert,
                confirmAction: {
                    viewModel.hideErrorAlert()
                }
            )
            .toolbar {
                
                ToolbarItem(placement: .confirmationAction) {
                    
                    TextButtonView(
                        title: "Save",
                        isDisabled: viewModel.isFormSavingDisabled,
                        isLoading: viewModel.isUpdating,
                        onPress: {
                            Task{
                                await viewModel.submit(onSuccess: onEditingComplete)
                                dismiss()
                            }
                        }
                    )
                    .fixedSize(horizontal: true, vertical: true)
                    
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    TextButtonView(
                        title: "Cancel",
                        isDisabled: viewModel.isUpdating,
                        onPress: {dismiss()}
                    )
                    
                    
                }
            }
        }
    }
}

#Preview {
    EditUserProfileView(
        user: UserDTO.test.toDomain(),
        onEditingComplete: {updatedUser in }
    )
}
