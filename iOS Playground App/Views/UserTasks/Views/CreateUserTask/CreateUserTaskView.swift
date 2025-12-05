//
//  CreateUserTaskView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 29/11/25.
//

import SwiftUI

typealias OnCreateUserTask = (_ newTask: UserTask) -> Void

struct CreateUserTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: ViewModel
    
    
    
    init() {

        let tasksRepository = DIContainer.shared.getInstance(of: TasksRepository.self)
        
        //let userId = DIContainer.shared.getInstance(of: AuthenticationManager.self).userId!
        
        let userId = AppConstants.MOCK_USER_ID // TODO: Remove after testing
        
        self._viewModel = StateObject(wrappedValue: ViewModel(
                userId: userId,
                tasksRepository: tasksRepository
            )
        )
    }
    
    var body: some View {
        NavigationStack{
            
            Form{
                
                TextFieldView(
                    label: "Title",
                    text: $viewModel.title
                )
                
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .alertDialog(
                title: viewModel.errorTitle,
                message: viewModel.errorMessage,
                isPresnted: $viewModel.showErrorAlert,
                confirmAction: viewModel.hideErrorMessage
            )
            .toolbar {
                
                ToolbarItem(placement: .confirmationAction) {
                    PrimaryButtonView(
                        title: "Add",
                        isLoading: viewModel.isSaving,
                        isDisabled: viewModel.isSavingButtonDisabled
                    ) {
                        viewModel.submit { createdTask in
                            //onSubmit(createdTask)
                            dismiss()
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    TextButtonView(
                        title: "Cancel",
                        isDisabled: viewModel.isSaving
                    ) {
                        dismiss()
                    }
                }
                
            }
        }
        .interactiveDismissDisabled(viewModel.isSaving)
    }
}

#Preview {
    CreateUserTaskView()
}
