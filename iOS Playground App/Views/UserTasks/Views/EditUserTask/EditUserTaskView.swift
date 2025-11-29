//
//  EditUserTaskView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 26/11/25.
//

import SwiftUI

typealias SubmitTasksChanges = (_ updatedTask: UserTask) -> Void

struct EditUserTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ViewModel
    
    var onSubmit: SubmitTasksChanges
    
    init(
        task: UserTask,
        onSubmit: @escaping SubmitTasksChanges
    ) {
        
        let tasksRepository = DIContainer.shared.getInstance(of: TasksRepository.self)

        //let userId = DIContainer.shared.getInstance(of: AuthenticationManager.self).userId!
        let userId = AppConstants.MOCK_USER_ID // TODO: Remove after testing
        
        self.onSubmit = onSubmit
        self._viewModel = StateObject(wrappedValue: ViewModel(
                userId: userId,
                userTask: task,
                tasksRepository: tasksRepository
            )
        )
        
        
    }
    var body: some View {
        
        NavigationStack {
            
            Form {
                TextFieldView(
                    label: "Title",
                    text: $viewModel.title
                )
            }
            .alertDialog(
                title: viewModel.errorTitle,
                message: viewModel.errorMessage,
                isPresnted: $viewModel.showError,
                confirmAction: viewModel.hideErrors
            )
            .navigationTitle("Edit task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .confirmationAction) {
                    PrimaryButtonView(
                        title: "Save",
                        isLoading: viewModel.isLoading,
                        onPress: {
                            viewModel.submitForm { userTask in
                                onSubmit(userTask)
                                dismiss()
                            }
                        }
                    )
                    .disabled(viewModel.isFormSavingDisabled)
                    .fixedSize(horizontal: true, vertical: true)
                }
                
                ToolbarItem(
                    placement: .cancellationAction) {
                        TextButtonView(
                            title: "Cancel",
                            isDisabled: viewModel.isLoading,
                            onPress: {dismiss()}
                        )
                    }
            }
        }
        .interactiveDismissDisabled(viewModel.isLoading)
        
    }
}

#Preview {
    EditUserTaskView(
        task: UserTask.testModel, onSubmit: { updatedTask in
            
        }
    )
}
