//
//  EditUserTaskViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 26/11/25.
//

import Foundation
import Combine

extension EditUserTaskView {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        private let userId: UserId
        private let tasksRepository: TasksRepository
        private let userTask: UserTask
        private var cancellables = Set<AnyCancellable>()
        
        
        @Published var isLoading: Bool = false
        @Published var isFormSavingDisabled: Bool = true
        @Published var title: String
        

        // Form Error Messages
        @Published var showError: Bool = false
        @Published var errorTitle: String = AppConstants.ERROR_TITLE_PLACEHOLDER
        @Published var errorMessage: String? = nil
        
        init(
            userId: UserId,
            userTask: UserTask,
            tasksRepository: TasksRepository
        ) {
            self.userId = userId
            self.userTask = userTask
            self.title = userTask.title
            self.tasksRepository = tasksRepository
            
            self.publishersRegister()
        }
        
        deinit {
            cancellables.removeAll()
        }
        
        
        private func publishersRegister() -> Void {
            
            self.titleChangesPublisher()
            
        }
        
        private func titleChangesPublisher() -> Void {
            
            $title
                .dropFirst()
                .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                .sink(receiveValue: checkIsFormSavingDisabled)
                .store(in: &cancellables)
            
        }
        
        private func checkIsFormSavingDisabled(with title: String) -> Void {
            
            let trimmedTitle = title.trim()
            
            self.isFormSavingDisabled = trimmedTitle.isEmpty || trimmedTitle == self.userTask.title
            
        }
        
        
        func submitForm(onComplete: @escaping (_ userTask: UserTask) -> Void ) -> Void {
                
            Task {
                do {
                    
                    self.hideErrors()
                    
                    self.isLoading = true
                    
                    let updatedUserTask = self.userTask.copyWith(title: self.title)
                    
                    let updatedUserTaskResponse = try await self.tasksRepository.updateTask(for: userTask.id, data: updatedUserTask)
                    
                    onComplete(updatedUserTaskResponse)
                    
                    self.isLoading = false
                    
                } catch let error as DataError {
                    
                    showErrorMessage(error)
                    
                } catch {
                    
                    self.showUnexpectedError()
                    
                }
            }
            
        }
        
        func hideErrors() -> Void {
            self.errorTitle = AppConstants.ERROR_TITLE_PLACEHOLDER
            self.errorMessage = nil
            self.showError = false
        }
        
        private func showErrorMessage(_ error: AppError) -> Void {
            
            self.errorTitle = error.title
            self.errorMessage = error.message
            self.showError = true
            self.isLoading = false
            
        }
    
        private func showUnexpectedError() -> Void {
            
            self.errorTitle = AppConstants.ERROR_TITLE_PLACEHOLDER
            self.errorMessage = "Something went wrong. Please try again."
            self.showError = true
            self.isLoading = false
            
        }
    }
    
}
